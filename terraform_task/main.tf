provider "aws" {
  region  = var.region
  profile = "admin"
}


data "aws_availability_zones" "available" {}

data "aws_ami" "latest_amazon" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

#------------ S3 -------------------------
resource "aws_s3_bucket" "b" {
  bucket = "gizarzigangirovandersenhw"
  acl    = "private"
  versioning {
    enabled = true
  }
  tags = {
    Name        = "andersen terraform task bucket"
    Environment = "dev"
  }
}


resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.b.id
  key    = "index.html"
  source = "index.html"

  etag = filemd5("index.html")
}

#-------------------------------------------------------


#--------- TLS KEY --------------------------------------
resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
  
  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.pk.private_key_pem}' > ~/.ssh/myKey.pem"
  }
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.pk.public_key_openssh
}
#--------------------------------------------------------


#----------- VPC GW SNs ---------------------------------
# Create a VPC to launch our instances into
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.prefix}VPC"
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name = "${var.prefix}GW"
  }
}


# Create a subnet to launch our instances into
resource "aws_subnet" "pr_a" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_subnet" "pr_b" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[1]
}


#------------------------------------------------------------

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}

# A security group for the ELB so it is accessible via the web
resource "aws_security_group" "elb" {
  name        = "security_group_elb"
  vpc_id      = "${aws_vpc.vpc.id}"

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "web" {
  name        = "security_group_instances"
  vpc_id      = "${aws_vpc.vpc.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_elb" "web" {
  name = "terraformtaskelb"

  subnets         = ["${aws_subnet.pr_a.id}","${aws_subnet.pr_b.id}"]
  security_groups = ["${aws_security_group.elb.id}"]
#  instances       = ["${aws_instance.web.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}

/* resource "aws_instance" "web" {
  ami        = data.aws_ami.latest_amazon.id
  depends_on = [tls_private_key.pk]

  connection {

    # The default username for our AMI
    user = "ec2-user"
    host = aws_instance.web.public_ip
    private_key = "${file("./myKey.pem")}"
    # The connection will use the local SSH agent for authentication.
  }
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.default.id]
  subnet_id = "${aws_subnet.default.id}"
  provisioner "remote-exec" {
    inline = [
      "sudo yum -y update",
      "sudo amazon-linux-extras install nginx1 -y",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }
} */


resource "aws_iam_instance_profile" "instprof" {
  name = "${var.prefix}-instprof"
  role = aws_iam_role.role_ec2_s3.name
}


resource "aws_launch_configuration" "web" {
  name_prefix     = "${var.prefix}LC_"
  image_id        = data.aws_ami.latest_amazon.id
  instance_type   = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.instprof.id
  security_groups = [aws_security_group.web.id]
  #depends_on = [tls_private_key.pk]

  key_name  = aws_key_pair.generated_key.key_name
  user_data = file("user_data.sh")
  

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "web" {
  name                 = "ASG-${aws_launch_configuration.web.name}"
  launch_configuration = aws_launch_configuration.web.name
  min_size             = 2
  max_size             = 2
  min_elb_capacity     = 2
  health_check_type    = "ELB"
  vpc_zone_identifier  = [aws_subnet.pr_a.id, aws_subnet.pr_b.id]
  #load_balancers       = [aws_elb.web.name]


  lifecycle {
    create_before_destroy = true
  }
}


# Create a new load balancer attachment
resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.web.id
  elb                    = aws_elb.web.id
}

resource "aws_iam_role" "role_ec2_s3" {
  name = "${var.prefix}-role-ec2-s3"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "${var.prefix}-role_ec2_s3"
  }

}

resource "aws_iam_role_policy" "pol" {
  name = "policy-ec2-s3"
  role = aws_iam_role.role_ec2_s3.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow",
        Action = [
          "s3:Get*",
          "s3:List*"
        ],
        Resource = "*"
      },
    ]
  })
}