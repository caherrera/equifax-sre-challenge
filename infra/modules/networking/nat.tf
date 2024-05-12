resource "aws_eip" "nat" {
  domain = "vpc"
  count  = local.count_with_nat
}

## NAT
resource "aws_nat_gateway" "ngw" {
  count         = local.count_with_nat
  subnet_id     = element(aws_subnet.public_subnet.*.id, count.index)
  allocation_id = aws_eip.nat[count.index].id
  depends_on    = [aws_internet_gateway.igw]
  tags = {
    Name = "ngw-${aws_subnet.public_subnet[count.index].availability_zone}"
  }
}