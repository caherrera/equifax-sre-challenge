resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

locals {
  password          = coalesce(var.password, random_password.password.result)
  identifier_master = "${var.name}-master"
}

resource "aws_db_instance" "default" {
  allocated_storage      = 10
  db_name                = var.db_name
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  username               = var.username
  password               = local.password
  parameter_group_name   = var.parameter_group_name
  skip_final_snapshot    = true
  identifier             = local.identifier_master
  db_subnet_group_name   = aws_db_subnet_group.private.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]


}

resource "aws_db_subnet_group" "private" {
  name       = "${var.name}-priv_subnet_group"
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "rds_sg" {
  name        = "sg-${var.name}-allow-mysql"
  description = "Allow MYSQL inbound traffic"
  vpc_id      = var.vpc_id
  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}