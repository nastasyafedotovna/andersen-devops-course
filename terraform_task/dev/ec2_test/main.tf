
provider "aws" {
  region  = var.region
  profile = "default"
}


#------search available zones in region
data "aws_availability_zones" "available" {}

#-----search latest amazon linux image in region
data "aws_ami" "latest_amazon" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

#-----creating vpc
resource "aws_vpc" "andersen_task_vpc" {
  cidr_block = var.cidr
  tags = {
    Name = "andersen_task-VPC"
  }
}



#-----creating private subnets in vpc
resource "aws_subnet" "sub_private_a"{
  vpc_id = aws_vpc.andersen_task_vpc.id
  cidr_block = var.cidr_private_a
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "private subnet A"
  }
}

resource "aws_subnet" "sub_private_b"{
  vpc_id = aws_vpc.andersen_task_vpc.id
  cidr_block = var.cidr_private_b
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "private subnet B"
  }
}

#-----creating public subnets in vpc
resource "aws_subnet" "sub_public_a"{
  vpc_id = aws_vpc.andersen_task_vpc.id
  cidr_block = var.cidr_public_a
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "public subnet A"
  }
}

resource "aws_subnet" "sub_public_b"{
  vpc_id = aws_vpc.andersen_task_vpc.id
  cidr_block = var.cidr_public_b
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "public subnet B"
  }
}

#data "aws_subnet_ids" "subnets" {
#  vpc_id = aws_vpc.andersen_task_vpc.id
#}

#data "aws_subnet" "example" {
#  for_each = data.aws_subnet_ids.subnets.ids
#  id       = each.value
#}

#output "aws_subnets" {
#  value = [for s in data.aws_subnet.example : s.cidr_block]
#}