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
  type = list(any)
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
  type = list(any)
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
  type = list(any)
}

variable "cache_subnet_group" {
  type = string
}

#varaibles - compute
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


# # code pipline varaibles 
variable codestar_connector_credentials {
  type = string
}
variable dockerhub_credentials{
    type = string
}
variable "s3_id" {
  type = string
  
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
#Route 53
variable "alb_dns_name" {
  type = string
}

variable "alb_zone_id" {
  type = string
}

/*
#variables from terraform_backend module
variable "stack_name" {
  type = string
  #default = "first"
}
*/