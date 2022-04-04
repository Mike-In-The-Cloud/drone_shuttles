output "loadbalancer_arn" {
  value = aws_lb.loadbalancer.arn
}

output "loadbalancer_dns_name" {
  value = aws_lb.loadbalancer.dns_name
}

output "loadbalancer_zone" {
  value = aws_lb.loadbalancer.zone_id
}