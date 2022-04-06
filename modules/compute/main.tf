#Load Balancer 
resource "aws_lb" "loadbalancer" {
  name = "${terraform.workspace}-CasestudyLB"
  #internal           = false
  load_balancer_type = "application"
  security_groups    = var.elb_security_group
  subnets            = var.elb_subnet_group
  idle_timeout       = "70"

  #enable_deletion_protection = true

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
  #user_data = filebase64("../shell/testfile.sh")
  user_data = base64encode(data.template_file.userdata.rendered)
  tags = {
    Name = "${terraform.workspace}-CasestudyLT"
  }
}

#Userdata Bash Script variables
data "template_file" "userdata" {
  template   = file("../shell/wordpress.sh")
  depends_on = [var.database_name, var.database_username, var.writer_endpoint, var.database_password, var.efsfileid, var.aws_region]
  vars = {
    DB_NAME     = var.database_name
    DB_HOSTNAME = var.writer_endpoint
    DB_USERNAME = var.database_username
    DB_PASSWORD = var.database_password
    WP_ADMIN    = "WPADMIN"
    WP_PASSWORD = "WPADMIN123"
    WP_EMAIL    = "xyz@xyz.com"
    LB_HOSTNAME = aws_lb.loadbalancer.dns_name
    EFSMOUNTID  = var.efsfileid
    AWSREGION   = var.aws_region
  }
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