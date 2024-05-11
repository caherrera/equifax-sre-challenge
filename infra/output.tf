output "vpc_id" {
  value = local.vpc_id
}

output "availability_zones" {
  value = local.availability_zones
}

output "private_subnet_ids" {
  value = module.networking.private_subnet_ids
}

output "public_subnet_ids" {
  value = module.networking.public_subnet_ids
}

output "database_subnet_ids" {
  value = module.networking.database_subnet_ids
}

output "default_security_group_id" {
  value = data.aws_security_group.default.id
}

output "database" {
  value = {
    secret_id = aws_secretsmanager_secret.database_password.id,
    address   = module.database.address
  }
}