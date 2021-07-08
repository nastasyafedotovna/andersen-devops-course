variable "region" {
    description = "region where resources will creating"
    type = string
    default = "eu-central-1"
}


variable "key_name" {
    description = "name of ssh key"
    type = string
    default = "myKey"
}

variable "prefix" {
    description = "prefix for name tag"
    type = string
    default = "andersen_terraform_task_"
}

variable "vpc_cidr" {
    description = "cidr block for vpc"
    type = string
    default = "10.0.0.0/16"
}
