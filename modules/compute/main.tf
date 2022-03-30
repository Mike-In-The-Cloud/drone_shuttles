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
resource "aws_lb_target_group" "target-group" {
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
    target_group_arn = aws_lb_target_group.target-group.arn
  }
}

#Launch Template
resource "aws_launch_template" "launch_template" {
  name_prefix   = "${terraform.workspace}-CasestudyLT"
  description   = "Launch Template for Case Study project"
  image_id      = var.imagetype
  instance_type = var.instancetype
}


#AutoScaling Group
resource "aws_autoscaling_group" "bar" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template = {
    id      = "${aws_launch_template.foobar.id}"
    version = "$$Latest"
  }
}