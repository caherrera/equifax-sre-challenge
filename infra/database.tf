module "database" {
  source                   = "./modules/database"
  vpc_id                   = local.vpc_id
  availability_zones       = local.availability_zones
  subnet_group_name        = module.networking.database_subnet_group
  source_security_group_id = aws_security_group.data-sg.id
  environment              = var.environment
  engine                   = "mysql"
  port                     = 3306
  dns_zone_id              = aws_route53_zone.zone.zone_id

}

resource "aws_secretsmanager_secret" "database_password" {
  name                    = "${var.environment}-${var.name}-db"
  description             = "Password for ${var.environment} database"
  recovery_window_in_days = 10                     # Optional: Recovery window
}

resource "aws_secretsmanager_secret_version" "database_password" {
  secret_id     = aws_secretsmanager_secret.database_password.id
  secret_string = jsonencode({
    username = module.database.database_username
    password = module.database.database_password
    host     = module.database.address
    port     = module.database.port
  })
}
