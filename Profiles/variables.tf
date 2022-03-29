#variables from vpc module
variable "cidr_block" {}
variable "PublicSubnet1Param" {}
variable "PublicSubnet2Param" {}
variable "AppSubnet1Param" {}
variable "AppSubnet2Param" {}
variable "DatabaseSubnet1Param" {}
variable "DatabaseSubnet2Param" {}

#variables - efs

variable "efssubnetname1" {
  type = string
}

variable "efssubnetname2" {
  type = string
}

variable "efssgname" {
  type = list
}

#variables - database module
variable "instanceclass" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "dbengine_type" {
  type = string  
}

variable "dbengine_version" {
  type = string  
}

variable "db_subnet_group" {
  type = string  
}

variable "db_security_group" {
  type = list 
}

variable "cache_engine" {
  type = string  
}

variable "cache_node_type" {
  type = string  
}

variable "cache_parameter_group" {
  type = string  
}

variable "cache_security_group" {
  type = list 
}

variable "cache_subnet_group" {
  type = string  
}
/*
#varaibles - compute

#variables from terraform_backend module
variable "stack_name" {
  type = string
  #default = "first"
}
*/