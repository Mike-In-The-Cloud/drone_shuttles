#moduleVPC
cidr_block           = "10.0.0.0/16"
PublicSubnet1Param   = "10.0.0.0/24"
PublicSubnet2Param   = "10.0.1.0/24"
AppSubnet1Param      = "10.0.2.0/24"
AppSubnet2Param      = "10.0.3.0/24"
DatabaseSubnet1Param = "10.0.4.0/24"
DatabaseSubnet2Param = "10.0.5.0/24"
#module-efs
efssubnetname1 = " "
efssubnetname2 = " "
efssgname      = [" "]
#module-databse
instanceclass         = "db.t3.small"
db_name               = "CasestudyDB"
db_username           = "admin"
db_password           = "admin123"
dbengine_type         = "aurora-mysql"
dbengine_version      = "5.7.mysql_aurora.2.07.2"
db_subnet_group       = " "
db_security_group     = [" "]
cache_engine          = "memcached"
cache_node_type       = "cache.t3.micro"
cache_parameter_group = "default.memcached1.6"
cache_security_group  = [" "]
cache_subnet_group    = " "

#module-compute
elb_security_group = [" "]
elb_subnet_group   = [" "]
vpcid              = " "
LTsecuritygroup    = [" "]
instancetype       = "t2.micro"
amiid              = "ami-0dcc0ebde7b2e00db"
appsubnets         = [" "]
efsfileid         = " "
database_name      = " "
writer_endpoint   = " "
database_username  = " "
database_password  = " "
aws_region         = " "
#Route 53
alb_dns_name = " "
alb_zone_id = " "


#module-pipeline
codestar_connector_credentials  = "arn:aws:codestar-connections:us-east-1:878915726377:connection/acae1ec3-3f96-4268-9358-370a730d385d"
dockerhub_credentials           = "arn:aws:secretsmanager:us-east-1:878915726377:secret:dockerv2-81Blng"
s3_id                           = " "
