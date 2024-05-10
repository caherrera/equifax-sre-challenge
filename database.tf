# SG EC2 => DB
resource "aws_security_group" "data-sg" {
  description = "controls data access"

  vpc_id = local.vpc_id
  name   = "${var.name} DATA Security Group"
}

#
# module "database" {
#   source     = "./modules/database"
#   vpc_id     = local.vpc_id
#   subnet_ids =
# }