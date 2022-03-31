#Load Balancer 
resource "aws_lb" "loadbalancer" {
  name               = "${terraform.workspace}-CasestudyLB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.elb_security_group
  subnets            = var.elb_subnet_group

  enable_deletion_protection = true

  tags = {
    Name = "${terraform.workspace}-CasestudyLB"
  }
}
#Target Group
resource "aws_alb_target_group" "target-group" {
  name     = "${terraform.workspace}-CasestudyTG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpcid

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 10
    timeout             = 50
    interval            = 60
    path                = "/wp-login.php"
  }
}
#listener
resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target-group.arn
  }
}

#Launch Template
<<<<<<< HEAD
resource "aws_launch_template" "launch_template_casestudy" {
  name_prefix = "${terraform.workspace}-CasestudyLT"
  description = "Launch Template for Case Study project"
  #image_id      = data.aws_ami.amiid.id
  image_id               = var.amiid
  instance_type          = var.instancetype
  vpc_security_group_ids = var.LTsecuritygroup
  monitoring {
    enabled = true
  }

  /*
  network_interfaces{
    #associate_carrier_ip_address = false
    associate_public_ip_address = false
    delete_on_termination = true
    description = "Primary network interface"
    #security_groups = var.LTsecuritygroup
  }
  */
  placement {
    tenancy = "default"
  }
  private_dns_name_options {
    hostname_type = "ip-name"
  }
  ebs_optimized = false
  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 8
      delete_on_termination = true
      volume_type           = "gp2"
    }
  }
  user_data = filebase64("../shell/testfile.sh")
  #user_data = filebase64("../shell/testfile.sh")
/*
  EFSMOUNTID  = var.efsfileid
  AWSREGION   = var.awsregion
  DB_NAME     = var.databaseName
  DB_HOSTNAME = var.writer_endpoint
  DB_USERNAME = var.databaseusername
  DB_PASSWORD = var.databasepassowrd
  LB_HOSTNAME = aws_lb.loadbalancer.dns_name
*/
  tags = {
    Name = "${terraform.workspace}-CasestudyLT"
  }
=======
resource "aws_launch_template" "launch_template" {
  name_prefix   = "${terraform.workspace}-CasestudyLT"
  description   = "Launch Template for Case Study project"
  image_id      = var.imagetype
  instance_type = var.instancetype
  user_data     = <<-EOF
  
  EOF
>>>>>>> f2166766dd5a448c2436b11ec4b6cf9c12243df5
}


#AutoScaling Group
resource "aws_autoscaling_group" "autoscaling_group" {
  #availability_zones = [data.aws_availability_zones.available-AZ.names[0],data.aws_availability_zones.available-AZ.names[1]]
  desired_capacity    = 1
  max_size            = 3
  min_size            = 1
  health_check_type   = "ELB"
  vpc_zone_identifier = var.appsubnets
  target_group_arns   = [aws_alb_target_group.target-group.arn]

  launch_template {
    id      = aws_launch_template.launch_template_casestudy.id
    version = "$Latest"
  }
<<<<<<< HEAD
  tags = [
    {
      "key"               = "Name",
      "value"             = "${terraform.workspace}-CasestudyASG"
      propagate_at_launch = true
    }
  ]

}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.id
  alb_target_group_arn   = aws_alb_target_group.target-group.arn
}
=======
}
>>>>>>> f2166766dd5a448c2436b11ec4b6cf9c12243df5
