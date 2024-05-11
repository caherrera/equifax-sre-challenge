resource aws_efs_file_system efs {
  tags = {
    Name = "efs-${var.environment}-${var.name}"
  }
}

resource aws_efs_mount_target mounts {
  for_each        = toset(var.efs_subnet_ids)
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = each.value
  security_groups = [aws_security_group.efs-sg.id]
}

resource aws_security_group efs-sg {
  name = "efs-sg-${var.environment}-${var.name}"
  tags = {
    Name = "efs-sg-${var.environment}-${var.name}"
  }
  vpc_id      = var.vpc_id
  description = "Allow ingress EFS traffic"

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    description = "Allow ingress EFS traffic"
  }
}