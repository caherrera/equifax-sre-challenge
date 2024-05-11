output "instance" {
  value = aws_autoscaling_group.asg_wp
}

output "security_group" {
  value = aws_security_group.http-sg.id

}

output "alb" {
  value = aws_alb.app[0].dns_name
}