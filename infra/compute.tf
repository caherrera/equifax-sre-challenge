resource "aws_key_pair" "carlos-key" {
  key_name   = "carlos-key"
  public_key = file("${path.module}/ssh-pub-keys/id_rsa.pub")
}
locals {
  host = "www.${var.domain}"
}

# module "compute" {
#   source     = "./modules/compute"
#   key_pair   = aws_key_pair.carlos-key.key_name
#   name       = "wordpress"
#   subnet_ids = module.networking.private_subnets.*.id
#   vpc_id     = local.vpc_id
#   hostname   = local.host
# }
