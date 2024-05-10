locals {
  hostname = var.hostname
}

resource "aws_lb" "app" {
  count              = var.expose ? 1 : 0
  load_balancer_type = "application"
  internal           = false
  name               = local.alb_prefix
  subnets            = var.subnet_ids
  security_groups    = [aws_security_group.app.id]

}

resource "aws_lb_target_group" "target_group" {
  name        = "${var.name}-alb-tg"
  port        = var.port
  protocol    = "HTTP"
  target_type = "alb"
  vpc_id      = var.vpc_id

}

resource "aws_lb_target_group_attachment" "app-http" {
  for_each = {
    for k, v in aws_instance.wp :
    k => v
  }
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = each.value.id
  port             = var.port
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app[0].arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }

}


resource "aws_lb_listener_rule" "app-port" {
  listener_arn = aws_lb_listener.app.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  condition {
    host_header {
      values = [local.hostname]
    }
  }
}