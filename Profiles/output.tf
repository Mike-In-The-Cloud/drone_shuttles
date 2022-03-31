#region output
output "AWS_Region" {
  value = data.aws_region.current.name
}

#outputs from VPC Module
output "VPCID" {
  value = module.casestudy_vpc.vpc-id
}

output "PublicSubnet1" {
  value = module.casestudy_vpc.PublicSubnet1Name
}

output "PublicSubnet2" {
  value = module.casestudy_vpc.PublicSubnet2Name
}

output "AppSubnet1" {
  value = module.casestudy_vpc.AppSubnet1Name
}

output "AppSubnet2" {
  value = module.casestudy_vpc.AppSubnet2Name
}

output "DatabaseSubnet1" {
  value = module.casestudy_vpc.DatabaseSubnet1Name
}

output "DatabaseSubnet2" {
  value = module.casestudy_vpc.DatabaseSubnet2Name
}

output "ElasticacheSubnetGroup" {
  value = module.casestudy_vpc.ElasticacheSubnetGroupName
}

output "RDSSubnetGroup" {
  value = module.casestudy_vpc.rdsSubnetGroupName
}

output "RDSSecurityGroup" {
  value = module.casestudy_vpc.rdsSecurityGroupName
}

output "AppInstanceSecurityGroup" {
  value = module.casestudy_vpc.AppinstanceSGName
}

output "ElastiCacheSecurityGroup" {
  value = module.casestudy_vpc.ElastiCacheSGName
}

output "EFSMountTargetSecurityGroup" {
  value = module.casestudy_vpc.EFSMountTargetSGName
}

output "LaunchTemplateSecurityGroup" {
  value = module.casestudy_vpc.LaunchTemplateSGName
}
#output - EFS Module
output "EFSFilesystemID" {
  value = module.casestudy_efs.EFSid
}
#outputs- database module
output "ClusterName" {
  value = module.casestudy_databse.ClusterName
}
output "reader-cluster-endpoint" {
  value = module.casestudy_databse.reader-cluster-endpoint
}

output "writer-cluster-endpoint" {
  value = module.casestudy_databse.writer-cluster-endpoint
}

output "Cache-configuration-endpoint" {
  value = module.casestudy_databse.cache-endpoint
}

output "Database_Name" {
  value = module.casestudy_databse.dbname
}

output "Database_Username" {
  value     = module.casestudy_databse.dbusername
  sensitive = true
}

output "Database_Password" {
  value     = module.casestudy_databse.dbpassword
  sensitive = true
}

#module - Loadbaalancer
output "loadbalancer_arn" {
  value = module.casestudy_compute.loadbalancer_arn
}

output "loadbalancer_dns_arn" {
  value = module.casestudy_compute.loadbalancer_dns_name
}
/*
#output - Terraform_backend module
output "s3bucketARN" {
    value = module.terraform_backend.bucket_arn
}

output "s3bucketid" {
    value = module.terraform_backend.bucket_id
}

*/