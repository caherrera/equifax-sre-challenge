resource aws_efs_file_system efs {
  tags = {
    Name = "efs-${var.environment}-${var.name}"
  }
}

resource "aws_efs_access_point" "ap" {
  file_system_id = aws_efs_file_system.efs.id
  root_directory {
    path = "/"
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
    security_groups = var.data_security_groups
  }

}

# resource "aws_efs_mount_target" "example" {
#   for_each         = toset(module.vpc.private_subnets_ids)
#   file_system_id   = aws_efs_file_system.example.id
#   subnet_id        = each.value
#   security_groups  = [aws_security_group.efs_sg.id]
# }
#
# resource "aws_security_group" "efs_sg" {
#   vpc_id = module.vpc.vpc_id
#
#   ingress {
#     from_port   = 2049
#     to_port     = 2049
#     protocol    = "tcp"
#     cidr_blocks = ["10.0.0.0/16"]  # Asegúrate de ajustar esto a la CIDR de tu VPC o subredes específicas
#   }
#
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   tags = {
#     Name = "EFS Security Group"
#   }
# }