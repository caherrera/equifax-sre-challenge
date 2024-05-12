locals {
  public_netnum_offset = coalesce(var.netnum_offset, var.public_netnum_offset)
  public_extra_offset  = 0
}

### Public Subnet, Nat and Route Tables
resource "aws_subnet" "public_subnet" {
  count             = var.az_count
  cidr_block        = coalesce(var.public_cidr_block, cidrsubnet(local.vpc_cidr_block, var.newbits, count.index + local.public_extra_offset + local.public_netnum_offset))
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = local.vpc_id
  tags              = merge({
    Name = "${var.name} Public Subnet ${data.aws_availability_zones.available.names[count.index]}"
  }, var.public_tags)
}

resource "aws_route_table" "public" {
  count  = var.az_count
  vpc_id = local.vpc_id
  tags = {
    Name = "${var.name} Public RT ${data.aws_availability_zones.available.names[count.index]}"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public[count.index].id
}


