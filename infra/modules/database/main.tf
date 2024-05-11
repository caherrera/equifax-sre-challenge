resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

locals {
  password               = coalesce(var.password, random_password.password.result)
  vpc_security_group_ids = concat([aws_security_group.rds_sg.id], var.security_groups)
  identifier_master      = "${var.identifier}-master"

}


resource "aws_db_instance" "master" {
  identifier              = "${var.identifier}-master"
  engine                  = var.engine
  allocated_storage       = var.allocated_storage
  instance_class          = var.instance_class
  db_name                 = var.db_name
  username                = var.username
  password                = local.password
  db_subnet_group_name    = var.subnet_group_name
  vpc_security_group_ids  = local.vpc_security_group_ids
  availability_zone       = var.availability_zones[0]
  skip_final_snapshot     = true
  apply_immediately       = true
  publicly_accessible     = false
  backup_retention_period = 7


  timeouts {
    create = "3h"
    delete = "3h"
    update = "3h"
  }

}

resource "aws_db_instance" "replica" {
  count                  = var.replica_count
  identifier             = "${var.identifier}-${format("s%02d", count.index)}"
  instance_class         = var.instance_class
  replicate_source_db    = aws_db_instance.master.identifier
  availability_zone      = var.availability_zones[count.index+1]
  skip_final_snapshot    = true
  depends_on             = [aws_db_instance.master]
  apply_immediately      = true
  publicly_accessible    = false
  vpc_security_group_ids = local.vpc_security_group_ids

  timeouts {
    create = "3h"
    delete = "3h"
    update = "3h"
  }

}

