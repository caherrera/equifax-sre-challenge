resource "aws_route53_zone" "zone" {
  name = var.domain
}

# resource "aws_route53_record" "website" {
#   name    = "www"
#   type    = "A"
#   ttl     = 300
#   zone_id = aws_route53_zone.zone.id
#   records = [module.wordpress.alb.dns_name]
# }