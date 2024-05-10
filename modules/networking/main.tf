data "aws_internet_gateway" "igw" {
  filter {
    name   = "attachment.vpc-id"
    values = [local.vpc_id]
  }
}

resource "aws_internet_gateway" "igw" {
  count = length(data.aws_internet_gateway.igw) ==0 ? 1 : 0
}

resource "aws_internet_gateway_attachment" "igw-vpc" {
  count               = length(data.aws_internet_gateway.igw) ==0 ? 1 : 0
  internet_gateway_id = aws_internet_gateway.igw[0].id
  vpc_id              = local.vpc_id
}

# resource "aws_eip" "nat" {
#   count = local.count_with_nat
#   #  domain   = "vpc"
#   tags = { Name = "ngw-eip-${aws_subnet.public_subnet[count.index].availability_zone}" }
#
# }