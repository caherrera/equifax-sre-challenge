output "vpc_id" {
  value = try(data.aws_vpc.main[0].id, "")
}

output "default_vpc_id" {
  value = try(aws_default_vpc.default[0].id, "")
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}
output "public_cidrs" {
  value = aws_subnet.public_subnet[*].cidr_block
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet[*].id
}

output "private_cidrs" {
  value = aws_subnet.private_subnet[*].cidr_block
}

output "database_subnet_group" {
  value = aws_db_subnet_group.database.id
}

output "database_subnet_ids" {
  value = aws_subnet.database_subnet[*].id
}

output "database_cidrs" {
  value = aws_subnet.database_subnet[*].cidr_block
}

output "availability_zones" {
  value = data.aws_availability_zones.available.names
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.ngw[*].id
}