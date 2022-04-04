variable "elb_security_group" {
  type = list(any)
}

variable "elb_subnet_group" {
  type = list(any)
}

variable "vpcid" {
  type = string
}

variable "LTsecuritygroup" {
  type = list(any)
}

variable "instancetype" {
  type = string
}

variable "amiid" {
  type = string
}

variable "appsubnets" {
  type = list(any)
}

variable "efsfileid" {
  type = string
}

variable "database_name" {
  type = string
}
variable "writer_endpoint" {
  type = string
}
variable "database_username" {
  type = string
}
variable "database_password" {
  type = string
}
variable "aws_region" {
  type = string
}

