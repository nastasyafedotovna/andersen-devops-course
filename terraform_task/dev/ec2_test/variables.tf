#variable "aws_access_key" {}

#variable "aws_secret_key" {}

#variable "aws_key_name" {}

variable "region" {
    type = string
    default = "eu-central-1"
}

variable "cidr" {
    type = string
    default = "10.0.0.0/16"
}

variable "cidr_private_a" {
  type = string
  description = "private subnet avalaible zone: a"
  default     = "10.0.1.0/24"
}
variable "cidr_private_b" {
  type = string
  description = "private subnet avalaible zone: b"
  default     = "10.0.3.0/24"
}

variable "cidr_public_a" {
  type = string
  description = "public subnet avalaible zone: a"
  default     = "10.0.2.0/24"
}
variable "cidr_public_b" {
  type = string
  description = "public subnet avalaible zone: b"
  default     = "10.0.4.0/24"
}
