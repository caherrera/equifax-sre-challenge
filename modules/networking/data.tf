data "aws_vpc" "main" {
  count = var.vpc_id != "" ? 1 : 0
  id    = var.vpc_id

}

resource "aws_default_vpc" "default" {
  count = var.vpc_id != "" ? 0 : 1
  tags = {
    Name = "Default"
  }
}

data "aws_availability_zones" "available" {}

locals {
  count_with_nat = var.use_nat == true ? var.az_count : 0
  vpc_id         = var.vpc_id != "" ? data.aws_vpc.main[0].id : aws_default_vpc.default[0].id
  vpc_cidr_block = var.vpc_id != "" ? data.aws_vpc.main[0].cidr_block : aws_default_vpc.default[0].cidr_block
}