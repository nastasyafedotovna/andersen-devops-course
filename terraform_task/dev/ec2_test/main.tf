data "aws_ami" "latest_amazon" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


resource "aws_instance" "ec2_web_server_a" {
  ami           = data.aws_ami.latest_amazon.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subprivate_a.id
}

resource "aws_instance" "ec2_web_server_b" {
  ami           = ""
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subprivate_b.id
}

resource "aws_vpc" "vpc_by_gizar" {
  cidr_block = var.fund_cidr
  tags = {
    Name = "terraform-task-VPC"
  }
}

resource "aws_subnet" "subpublic_a" {
  vpc_id            = aws_vpc.vpc_by_gizar.id
  cidr_block        = var.cidr_subpub_a
  availability_zone = "${var.region}a"

  tags = {
    Name = "terraform-task-subpublic-a"
  }
}


resource "aws_subnet" "subprivate_a" {
  vpc_id            = aws_vpc.vpc_by_gizar.id
  cidr_block        = var.cidr_subprivate_a
  availability_zone = "${var.region}a"

  tags = {
    Name = "terraform-task-subprivate-a"
  }
}

resource "aws_subnet" "subpublic_b" {
  vpc_id            = aws_vpc.vpc_by_gizar.id
  cidr_block        = var.cidr_subpub_b
  availability_zone = "${var.region}b"

  tags = {
    Name = "terraform-task-subpublic-a"
  }
}


resource "aws_subnet" "subprivate_b" {
  vpc_id            = aws_vpc.vpc_by_gizar.id
  cidr_block        = var.cidr_subprivate_b
  availability_zone = "${var.region}b"

  tags = {
    Name = "terraform-task-subprivate-b"
  }
}
