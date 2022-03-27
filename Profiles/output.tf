#outputs from VPC Module
output "VPCID" {
    value = module.casetsudy_vpc.vpc-id
}

output "PublicSubnet1" {
    value = module.casetsudy_vpc.PublicSubnet1Name
}

output "PublicSubnet2" {
  value = module.casetsudy_vpc.PublicSubnet2Name
}

output "AppSubnet1" {
    value = module.casetsudy_vpc.AppSubnet1Name
}

output "AppSubnet2" {
    value = module.casetsudy_vpc.AppSubnet2Name
}

output "DatabaseSubnet1" {
    value = module.casetsudy_vpc.DatabaseSubnet1Name
}

output "DatabaseSubnet2" {
    value = module.casetsudy_vpc.DatabaseSubnet2Name
}

output "ElasticacheSubnetGroup" {
    value = module.casetsudy_vpc.ElasticacheSubnetGroupName
}

output "RDSSubnetGroup" {
    value = module.casetsudy_vpc.rdsSubnetGroupName
}

output "RDSSecurityGroup" {
    value = module.casetsudy_vpc.rdsSGName
}

output "AppInstanceSecurityGroup" {
    value = module.casetsudy_vpc.AppinstanceSGName
}

output "ElastiCacheSecurityGroup" {
    value = module.casetsudy_vpc.ElastiCacheSGName
}

output "EFSMountTargetSecurityGroup" {
    value = module.casetsudy_vpc.EFSMountTargetSGName
}
/*
#output - Terraform_backend module
output "s3bucketARN" {
    value = module.terraform_backend.bucket_arn
}

output "s3bucketid" {
    value = module.terraform_backend.bucket_id
}

#output - EFS
output "EFSfileID" {
    value = module.casestudy_efs.EFSid
}
*/