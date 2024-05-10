### Private Subnet, Nat and Route Tables
locals {
  private_netnum_offset = coalesce(var.netnum_offset, var.private_netnum_offset )
  private_extra_offset  = var.netnum_offset !=null ? var.az_count : 0

}
resource "aws_subnet" "private_subnet" {
  count             = var.az_count
  cidr_block        = coalesce(var.private_cidr_block, cidrsubnet(local.vpc_cidr_block, var.newbits, count.index + local.private_netnum_offset + local.private_extra_offset))
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = local.vpc_id
  tags              = merge({
    Name = "${var.name} Private Subnet ${data.aws_availability_zones.available.names[count.index]}"
  }, var.private_tags)
}

resource "aws_route_table" "private" {
  count  = length(aws_nat_gateway.ngw)
  vpc_id = local.vpc_id

  tags = {
    Name = "${var.name} Private RT ${data.aws_availability_zones.available.names[count.index]}"
  }

  route {
    nat_gateway_id = aws_nat_gateway.ngw[count.index].id
    cidr_block     = "0.0.0.0/0"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(aws_route_table.private)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private[count.index].id
}