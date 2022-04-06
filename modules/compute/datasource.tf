data "aws_availability_zones" "available-AZ" {
  state = "available"
}
 
/*
data "aws_ami" "amiid" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["Amazon Linux 2 AMI"]
  }

  filter {
    name   = "architecture"
    values = ["64-bit Arm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
*/