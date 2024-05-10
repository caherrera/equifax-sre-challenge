output "vpc_id" {
  value = try(data.aws_vpc.main[0].id, "")
}

output "default_vpc_id" {
  value = try(aws_default_vpc.default[0].id, "")
}

output "public_ids" {
  value = aws_subnet.public_subnet[*].id
}
output "public_cidrs" {
  value = aws_subnet.public_subnet[*].cidr_block
}