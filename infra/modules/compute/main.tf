locals {
  ec2_prefix      = coalesce(var.ec2_prefix, var.name)
  alb_prefix      = coalesce(var.alb_prefix, "${local.ec2_prefix}-alb")
  alb_logs_bucket = "${local.alb_prefix}-logs"
  sg_name_svc     = "${local.ec2_prefix}-svc-sg"
  sg_name_lb      = "${local.ec2_prefix}-lb-sg"
  ami             = var.ami == "" ? "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*" : var.ami
  ami_owner       = var.ami == "" ? "099720109477" : data.aws_caller_identity.current.account_id

}

data "aws_caller_identity" "current" {}


data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = [local.ami]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [local.ami_owner]
}


resource "aws_launch_template" "lt_wp" {
  name_prefix   = var.name
  image_id      = data.aws_ami.ami.image_id
  instance_type = var.instance_type
  key_name      = var.key_pair

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups             = concat([
      aws_security_group.http-sg.id,
    ], var.security_groups)
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.name
    }
  }

  depends_on = [aws_security_group.http-sg]

}

resource "aws_placement_group" "pg_wp" {
  name     = "${var.name}-pg"
  strategy = "cluster"
}

resource "aws_autoscaling_group" "asg_wp" {
  name                      = "${var.name}-asg"
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  placement_group           = aws_placement_group.pg_wp.name
  target_group_arns         = [aws_alb_target_group.target_group.arn]
  health_check_grace_period = 300
  termination_policies      = ["OldestInstance"]
  vpc_zone_identifier       = var.instances_subnet_ids

  launch_template {
    id      = aws_launch_template.lt_wp.id
    version = "$Latest"
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_lifecycle_hook" "asg_lifecycle_hook" {
  name                   = "${aws_autoscaling_group.asg_wp.name}-lifecycle-hook"
  autoscaling_group_name = aws_autoscaling_group.asg_wp.name
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
  heartbeat_timeout      = 300
  default_result         = "CONTINUE"
}