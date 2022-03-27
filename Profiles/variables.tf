#variables from vpc module
variable "cidr_block" {}
variable "PublicSubnet1Param" {}
variable "PublicSubnet2Param" {}
variable "AppSubnet1Param" {}
variable "AppSubnet2Param" {}
variable "DatabaseSubnet1Param" {}
variable "DatabaseSubnet2Param" {}
/*
#variables - database module

#variables - efs
variable "efssubnetname" {
  type = list
}

variable "efssgname" {
  type = list
}


#varaibles - compute

#variables from terraform_backend module
variable "stack_name" {
  type = string
  #default = "first"
}
*/