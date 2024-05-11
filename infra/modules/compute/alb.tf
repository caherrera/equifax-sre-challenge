locals {
  hostname = var.hostname
}

resource "aws_alb" "app" {
  count              = var.expose ? 1 : 0
  load_balancer_type = "application"
  internal           = false
  name               = local.alb_prefix
  subnets            = var.subnet_ids
  security_groups    = [aws_security_group.app.id]

}

resource "aws_alb_target_group" "target_group" {
  name     = "${var.name}-alb-tg"
  port     = var.port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    interval            = 30
    path                = "/"
    port                = 80
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    protocol            = "HTTP"
    matcher             = "200,202"
  }

}


resource "aws_alb_listener" "app" {
  load_balancer_arn = aws_alb.app[0].arn
  port              = var.port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_group.arn
  }

}


resource "aws_alb_listener_rule" "app-port" {
  listener_arn = aws_alb_listener.app.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_group.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

#   condition {
#     host_header {
#       values = [local.hostname]
#     }
#   }
}