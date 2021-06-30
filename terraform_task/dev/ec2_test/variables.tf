variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_key_name" {}

variable "region" {}

variable "fund_cidr" {
  default = "172.16.0.0/16"
}

variable "cidr_subprivate_a" {
  description = "private subnet AV - a"
  default     = "172.16.2.0/24"
}

variable "cidr_subpub_a" {
  description = "public subnet AZ - a"
  default     = "172.16.1.0/24"
}


variable "cidr_subprivate_b" {
  description = "private subnet AV - b"
  default     = "172.16.4.0/24"
}

variable "cidr_subpub_b" {
  description = "public subnet AZ - b"
  default     = "172.16.3.0/24"
}
