resource "aws_route53_zone" "zone" {
  name = var.domain
}


resource "aws_route53_record" "website" {
  name    = var.environment == "prod" ? "www" : "${var.environment}-wp"
  type    = "CNAME"
  ttl     = 300
  zone_id = aws_route53_zone.zone.id
  records = [module.compute.alb]
}

resource "aws_route53_record" "db" {
  name    = "${var.environment}-db"
  type    = "CNAME"
  ttl     = 300
  zone_id = aws_route53_zone.zone.id
  records = [module.database.address]
}