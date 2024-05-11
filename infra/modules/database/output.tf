output "security_group" {
  value = aws_security_group.rds_sg.id
}

output "security_group_ids" {
  value = local.vpc_security_group_ids
}

output "database_username" {
  value = var.username
}

output "database_password" {
  value = local.password
}

output "database_name" {
  value = var.database_name
}

output "address" {
  value = aws_db_instance.master.address
}

output "replicas_addresses" {
  value = aws_db_instance.replica[*].address
}


output "port" {
  value = aws_db_instance.master.port
}


output "master_id" {
  value = aws_db_instance.master.id
}

output "replica_ids" {
  value = aws_db_instance.replica[*].id
}