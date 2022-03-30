#import Hosted Zone
#create a A record
#
resource "aws_route53_zone" "main-dns-name" {
  name = "droneshuttles.ga"
   tags = {
    Environment = "${terraform.workspace}-CasestudyMainDNS"
  }
}

resource "aws_route53_zone" "dev-dns-name" {
  name = "dev-env.droneshuttles.ga"

  tags = {
    Environment = "${terraform.workspace}-CasestudydevDNS"
  }
}

resource "aws_route53_record" "dev-ns" {
  zone_id = aws_route53_zone.main-dns-name.zone_id
  name    = "dev-env.droneshuttles.ga"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.dev-dns-name.name_servers
}