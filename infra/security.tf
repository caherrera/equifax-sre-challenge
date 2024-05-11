data "aws_security_group" "default" {
  vpc_id = local.vpc_id
  filter {
    name   = "group-name"
    values = ["default"]
  }
}

resource "aws_security_group" "data-sg" {
  vpc_id                 = local.vpc_id
  name                   = "${var.name} DATA Security Group"
  revoke_rules_on_delete = true
  tags = {
    Name = "${var.name}-data-sg"
  }

  lifecycle {
    create_before_destroy = true
  }

}