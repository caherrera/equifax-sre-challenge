### Database Subnet, Nat and Route Tables
locals {
  database_netnum_offset = coalesce(var.netnum_offset, var.database_netnum_offset)
  database_extra_offset  = var.netnum_offset !=null ? var.az_count : 0

}
resource "aws_subnet" "database_subnet" {
  count             = var.az_count
  cidr_block        = coalesce(var.database_cidr_block, cidrsubnet(local.vpc_cidr_block, var.newbits, count.index + local.database_netnum_offset + local.database_extra_offset))
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = local.vpc_id
  tags              = merge({
    Name = "${var.name} Database Subnet ${data.aws_availability_zones.available.names[count.index]}"
  }, var.database_tags)
}

resource "aws_route_table" "database" {
  count  = length(aws_nat_gateway.ngw)
  vpc_id = local.vpc_id

  tags = {
    Name = "${var.name} Database RT ${data.aws_availability_zones.available.names[count.index]}"
  }

  route {
    nat_gateway_id = aws_nat_gateway.ngw[count.index].id
    cidr_block     = "0.0.0.0/0"
  }
}

resource "aws_route_table_association" "database" {
  count          = length(aws_route_table.database)
  subnet_id      = element(aws_subnet.database_subnet.*.id, count.index)
  route_table_id = aws_route_table.database[count.index].id
}

resource "aws_db_subnet_group" "database" {
  name       = "database_subnet_group"
  subnet_ids = aws_subnet.database_subnet.*.id
}
