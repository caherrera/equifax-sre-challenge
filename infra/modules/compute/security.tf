# USER => ALB SG
resource "aws_security_group" "app" {
  description = "controls access to the application ALB"

  vpc_id = var.vpc_id
  name   = local.sg_name_lb
  tags = { Name = local.sg_name_lb }

  ingress {
    protocol    = "tcp"
    from_port   = var.port
    to_port     = var.port
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  lifecycle {
    create_before_destroy = true
  }
}


# ALB => EC2 SG
resource "aws_security_group" "http-sg" {
  vpc_id      = var.vpc_id
  name        = "${var.name}-http-sg"
  tags = { Name = "${var.name}-http-sg" }
  description = "APP Service sg"
  ingress {
    from_port       = var.port
    to_port         = var.port
    protocol = "tcp"
    # Only allowing traffic in from the load balancer security group
    security_groups = [aws_security_group.app.id]
  }


  lifecycle {
    create_before_destroy = true
  }
}

