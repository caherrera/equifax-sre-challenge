output "instance" {
  value = aws_instance.wp
}

output "sgs" {
  value = {
    ssh  = aws_security_group.ssh-sg
    http = aws_security_group.http-sg
  }
}

output "alb" {
  value = aws_lb.app[0]
}