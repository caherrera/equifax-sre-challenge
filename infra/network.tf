data "aws_availability_zones" "available" {}

locals {
  availability_zones = slice(data.aws_availability_zones.available.names, 0, var.az_count)
  vpc_id             = coalesce(module.networking.vpc_id, module.networking.default_vpc_id)
}


module "networking" {
  source = "./modules/networking"
  name   = var.name
}

