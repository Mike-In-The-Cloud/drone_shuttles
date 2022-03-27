data "aws_availability_zones" "available-eu-central-1" {
  state = "available"
}

# Creating VPC here
# Defining the CIDR block use 10.0.0.0/16 for demo
resource "aws_vpc" "CaseStudyVPC" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "CaseStudyVPC"
  }
}

# Creating Internet Gateway
resource "aws_internet_gateway" "IGW-Casestudy" {    
  vpc_id =  aws_vpc.CaseStudyVPC.id  
  tags = {
    Name = "IGW-Casestudy"
  }            
}

#Creating Elastic ID Addresses and NAT Gateway
resource "aws_eip" "ElasticIPAddress1" {
   vpc   = true
 }

 resource "aws_nat_gateway" "NATGateway1" {
   allocation_id = aws_eip.ElasticIPAddress1.id
   subnet_id = aws_subnet.PublicSubnet1.id
   tags = {
    Name = "NATGateway1"
    } 
  }

 resource "aws_eip" "ElasticIPAddress2" {
   vpc   = true
 }

 resource "aws_nat_gateway" "NATGateway2" {
   allocation_id = aws_eip.ElasticIPAddress2.id
   subnet_id = aws_subnet.PublicSubnet2.id
   tags = {
    Name = "NATGateway2"
    } 
  }

#Subnets
resource "aws_subnet" "PublicSubnet1" {    
  vpc_id =  aws_vpc.CaseStudyVPC.id
  availability_zone = data.aws_availability_zones.available-eu-central-1.names[0]
  cidr_block = "${var.PublicSubnet1Param}"  
  tags = {
    Name = "PublicSubnet1"
  }     
}

resource "aws_subnet" "PublicSubnet2" {    
  vpc_id =  aws_vpc.CaseStudyVPC.id
  availability_zone = data.aws_availability_zones.available-eu-central-1.names[1]
  cidr_block = "${var.PublicSubnet2Param}"  
  tags = {
    Name = "PublicSubnet2"
  }     
}

resource "aws_subnet" "AppSubnet1" {    
  vpc_id =  aws_vpc.CaseStudyVPC.id
  availability_zone = data.aws_availability_zones.available-eu-central-1.names[0]
  cidr_block = "${var.AppSubnet1Param}"  
  tags = {
    Name = "AppSubnet1"
  }     
}

resource "aws_subnet" "AppSubnet2" {    
  vpc_id =  aws_vpc.CaseStudyVPC.id
  availability_zone = data.aws_availability_zones.available-eu-central-1.names[1]
  cidr_block = "${var.AppSubnet2Param}"  
  tags = {
    Name = "AppSubnet2"
  }     
}

resource "aws_subnet" "DatabaseSubnet1" {    
  vpc_id =  aws_vpc.CaseStudyVPC.id
  availability_zone = data.aws_availability_zones.available-eu-central-1.names[0]
  cidr_block = "${var.DatabaseSubnet1Param}"  
  tags = {
    Name = "DatabaseSubnet1"
  }     
}

resource "aws_subnet" "DatabaseSubnet2" {    
  vpc_id =  aws_vpc.CaseStudyVPC.id
  availability_zone = data.aws_availability_zones.available-eu-central-1.names[1]
  cidr_block = "${var.DatabaseSubnet2Param}"  
  tags = {
    Name = "DatabaseSubnet2"
  }     
}

#Elastic Cache Subnet Group
resource "aws_elasticache_subnet_group" "ElasticacheSubnetGroup" {
  name       = "ElasticacheSubnetGroup"
  description = "This Elasticache subnet group selects the same subnets as is used for the Aurora DB in task 2"
  subnet_ids = [aws_subnet.AppSubnet1.id,aws_subnet.AppSubnet2.id]
  tags = {
    Name = "ElasticacheSubnetGroup"
  }
}

#Route Tables
resource "aws_route_table" "PublicRouteTable" {
  vpc_id = aws_vpc.CaseStudyVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW-Casestudy.id
  }
  tags = {
    Name = "PublicRouteTable"
  }
}

resource "aws_route_table" "PrivateRouteTableAZ1" {
  vpc_id = aws_vpc.CaseStudyVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NATGateway1.id
  }
  tags = {
    Name = "PrivateRouteTableAZ1"
  }
}

resource "aws_route_table" "PrivateRouteTableAZ2" {
  vpc_id = aws_vpc.CaseStudyVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NATGateway2.id
  }
  tags = {
    Name = "PrivateRouteTableAZ2"
  }
}
 
#Subnet Associations
resource "aws_route_table_association" "PublicSubnet1RTA" {
    subnet_id = aws_subnet.PublicSubnet1.id
    route_table_id = aws_route_table.PublicRouteTable.id
 }

resource "aws_route_table_association" "PublicSubnet2RTA" {
    subnet_id = aws_subnet.PublicSubnet2.id
    route_table_id = aws_route_table.PublicRouteTable.id
 }

resource "aws_route_table_association" "AppSubnet1RTA" {
    subnet_id = aws_subnet.AppSubnet1.id
    route_table_id = aws_route_table.PrivateRouteTableAZ1.id
 }

resource "aws_route_table_association" "DatabaseSubnet1RTA" {
    subnet_id = aws_subnet.DatabaseSubnet1.id
    route_table_id = aws_route_table.PrivateRouteTableAZ1.id
 }

resource "aws_route_table_association" "AppSubnet2RTA" {
    subnet_id = aws_subnet.AppSubnet2.id
    route_table_id = aws_route_table.PrivateRouteTableAZ2.id
 }

resource "aws_route_table_association" "DatabaseSubnet2RTA" {
    subnet_id = aws_subnet.DatabaseSubnet2.id
    route_table_id = aws_route_table.PrivateRouteTableAZ2.id
 }

#Security Group
resource "aws_security_group" "AppInstanceSecurityGroup" {
  name        = "AppInstanceSecurityGroup"
  description = "Security Group allowing HTTP traffic for lab instances"
  vpc_id      = aws_vpc.CaseStudyVPC.id

  ingress {
    #description      = "TCP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AppInstanceSecurityGroup"
  }
}

resource "aws_security_group" "RDSSecurityGroup" {
  name        = "RDSSecurityGroup"
  description = "Security Group allowing RDS instances to have internet traffic"
  vpc_id      = aws_vpc.CaseStudyVPC.id

  ingress {
    #description      = "TCP from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDSSecurityGroup"
  }
}

resource "aws_security_group" "ElastiCacheSecurityGroup" {
  name        = "ElastiCacheSecurityGroup"
  description = "Security Group allowing ElastiCache to have internet traffic"
  vpc_id      = aws_vpc.CaseStudyVPC.id

  ingress {
    #description      = "TCP from VPC"
    from_port        = 11211
    to_port          = 11211
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ElastiCacheSecurityGroup"
  }
}

resource "aws_security_group" "EFSMountTargetSecurityGroup" {
  name        = "EFSMountTargetSecurityGroup"
  description = "Security Group allowing traffic between EFS Mount Targets and Amazon EC2 instances"
  vpc_id      = aws_vpc.CaseStudyVPC.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  =["${aws_security_group.AppInstanceSecurityGroup.id}"]
    #cidr_blocks      = var.cidr_block_subnet
  }

  ingress {
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  

  tags = {
    Name = "EFSMountTargetSecurityGroup"
  }
}

#RDS subnet GROUP
resource "aws_db_subnet_group" "auroraSubnetGroup" {
  name       = "aurorasubnetgroup"
  subnet_ids = [aws_subnet.DatabaseSubnet1.id, aws_subnet.DatabaseSubnet2.id]

  tags = {
    Name = "auroraSubnetGroup"
  }
}









