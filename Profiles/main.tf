terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

module "casetsudy_vpc" {
    source = "../modules/vpc"
    cidr_block = var.cidr_block
    PublicSubnet1Param = var.PublicSubnet1Param
    PublicSubnet2Param = var.PublicSubnet2Param
    AppSubnet1Param = var.AppSubnet1Param
    AppSubnet2Param = var.AppSubnet2Param
    DatabaseSubnet1Param = var.DatabaseSubnet1Param
    DatabaseSubnet2Param = var.DatabaseSubnet2Param
    
}
/*
module "casestudy_efs" {
    source = "../modules/efs"
    efssubnetname = [output.AppSubnet1,output.AppSubnet2]
    efssgname = [output.EFSMountTargetSecurityGroup]
  
}

module "casestudy_databse" {
    source = "../modules/database"
  
}

module "casestudy_compute" {
    source = "../modules/compute"
  
}

module "terraform_state_backend" {
    source = "../modules/terraform_backend"
    stack_name      = var.stack_name
  
}
*/