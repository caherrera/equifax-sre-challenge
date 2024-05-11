resource "aws_route53_record" "master" {
  zone_id = var.dns_zone_id
  name    = "${var.environment}-${local.identifier_master}"
  type    = "A"

  alias {
    name                   = aws_db_instance.master.address
    zone_id                = aws_db_instance.master.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "replica" {
  zone_id = var.dns_zone_id
  count   = var.replica_count
  name    = "${var.environment}-${var.identifier}-${format("s%02d", count.index)}"
  type    = "A"
  alias {
    name                   = aws_db_instance.replica[count.index].address
    zone_id                = aws_db_instance.replica[count.index].hosted_zone_id
    evaluate_target_health = false
  }
}


resource "aws_route53_record" "db" {
  name           = "${var.environment}-${var.identifier}"
  type           = "A"
  zone_id        = var.dns_zone_id
  set_identifier = "${var.environment}-${var.identifier}-primary"
  failover_routing_policy {
    type = "PRIMARY"
  }
  alias {
    name                   = aws_db_instance.master.address
    zone_id                = aws_db_instance.master.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "db-failover" {
  count          = var.replica_count
  name           = "${var.environment}-${var.identifier}"
  type           = "A"
  zone_id        = var.dns_zone_id
  set_identifier = "${var.environment}-${var.identifier}-failover-${format("s%02d", count.index)}"
  failover_routing_policy {
    type = "SECONDARY"
  }
  alias {
    name                   = aws_db_instance.replica[count.index].address
    zone_id                = aws_db_instance.replica[count.index].hosted_zone_id
    evaluate_target_health = true
  }
}