
output "dev_dns_name" {
    value = aws_route53_record.alb_endpoint.name
}
