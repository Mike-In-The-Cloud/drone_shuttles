#import Hosted Zone
#create a A record
#
resource "aws_route53_zone" "main-dns-name" {
  name = "droneshuttles.ml"
   tags = {
    Environment = "${terraform.workspace}-CasestudyMainDNS"
  }
}

resource "aws_route53_zone" "dev-dns-name" {
  name = "dev-env.droneshuttles.ml"

  tags = {
    Environment = "${terraform.workspace}-CasestudydevDNS"
  }
}

resource "aws_route53_record" "dev-ns" {
  zone_id = aws_route53_zone.main-dns-name.zone_id
  name    = "dev-env.droneshuttles.ml"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.dev-dns-name.name_servers
}

resource "aws_route53_record" "alb_endpoint" {
  zone_id = aws_route53_zone.dev-dns-name.id
  name    = "dev-env.droneshuttles.ml"
  type     = "A"
  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
