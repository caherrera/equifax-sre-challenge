data "aws_availability_zones" "available" {}

locals {
  azs    = slice(data.aws_availability_zones.available.names, 0, 2)
  vpc_id = coalesce(module.networking.vpc_id, module.networking.default_vpc_id)
}


module "networking" {
  source = "./modules/networking"
  name   = var.name
}

output "availability_zones" { value = local.azs }
