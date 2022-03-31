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
/*
variable "efsfileid  " {
  type = string
}
variable "awsregion" {
  type = string
}
variable "databaseName " {
  type = string
}
variable "writer_endpoint " {
  type = string
}
variable "databaseusername" {
  type = string
}
variable "databasepassowrd" {
  type = string
}
*/