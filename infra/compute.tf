resource "aws_key_pair" "carlos-key" {
  key_name   = "carlos-key"
  public_key = file("${path.module}/ssh-pub-keys/id_rsa.pub")
}
locals {
  host = "www.${var.domain}"
}

module "compute" {
  source             = "./modules/compute"
  key_pair           = aws_key_pair.carlos-key.key_name
  name               = var.name
  subnet_ids         = module.networking.private_subnet_ids
  vpc_id             = local.vpc_id
  hostname           = local.host
  availability_zones = local.azs
  ami                = var.ami
  max_size           = var.az_count*2
  min_size           = var.az_count
  desired_capacity   = var.az_count

}


module "bastion" {
  source        = "caherrera/bastion/aws"
  version       = "0.1.2"
  subnet_id     = module.networking.public_subnet_ids[0]
  key_pair_name = aws_key_pair.carlos-key.key_name
}