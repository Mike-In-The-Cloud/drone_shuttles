terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

data "aws_region" "current" {}

module "casestudy_vpc" {
  source               = "../modules/vpc"
  cidr_block           = var.cidr_block
  PublicSubnet1Param   = var.PublicSubnet1Param
  PublicSubnet2Param   = var.PublicSubnet2Param
  AppSubnet1Param      = var.AppSubnet1Param
  AppSubnet2Param      = var.AppSubnet2Param
  DatabaseSubnet1Param = var.DatabaseSubnet1Param
  DatabaseSubnet2Param = var.DatabaseSubnet2Param

}

module "casestudy_efs" {
  source         = "../modules/efs"
  efssubnetname1 = module.casestudy_vpc.AppSubnet1Name
  efssubnetname2 = module.casestudy_vpc.AppSubnet2Name
  efssgname      = [module.casestudy_vpc.EFSMountTargetSGName]

}

module "casestudy_databse" {
  source                = "../modules/database"
  db_subnet_group       = module.casestudy_vpc.rdsSubnetGroupName
  db_security_group     = [module.casestudy_vpc.rdsSecurityGroupName]
  db_username           = var.db_username
  db_password           = var.db_password
  dbengine_type         = var.dbengine_type
  dbengine_version      = var.dbengine_version
  instanceclass         = var.instanceclass
  db_name               = var.db_name
  cache_engine          = var.cache_engine
  cache_node_type       = var.cache_node_type
  cache_parameter_group = var.cache_parameter_group
  cache_security_group  = [module.casestudy_vpc.ElastiCacheSGName]
  cache_subnet_group    = module.casestudy_vpc.ElasticacheSubnetGroupName


}

module "casestudy_compute" {
  source             = "../modules/compute"
  elb_security_group = [module.casestudy_vpc.AppinstanceSGName]
  elb_subnet_group   = [module.casestudy_vpc.PublicSubnet1Name, module.casestudy_vpc.PublicSubnet2Name]
  vpcid              = module.casestudy_vpc.vpc-id
  LTsecuritygroup    = [module.casestudy_vpc.LaunchTemplateSGName, module.casestudy_vpc.rdsSecurityGroupName, module.casestudy_vpc.ElastiCacheSGName, module.casestudy_vpc.EFSMountTargetSGName]
  instancetype       = var.instancetype
  amiid              = var.amiid
  appsubnets         = [module.casestudy_vpc.AppSubnet1Name, module.casestudy_vpc.AppSubnet2Name]
/*
  efsfileid        = module.casestudy_efs.EFSid
  awsregion        = data.aws_region.current
  databaseName     = module.casestudy_databse.dbname
  writer_endpoint  = module.casestudy_databse.writer-cluster-endpoint
  databaseusername = module.casestudy_databse.dbusername
  databasepassowrd = module.casestudy_databse.dbpassword
*/
}
/*
module "casestudy_route53" {
  source = "../modules/route53"
}


module "terraform_state_backend" {
    source = "../modules/terraform_backend"
    stack_name      = var.stack_name
  
}



*/