locals {
  ec2_prefix      = coalesce(var.ec2_prefix, var.name)
  alb_prefix      = coalesce(var.alb_prefix, "${local.ec2_prefix}-alb")
  alb_logs_bucket = "${local.alb_prefix}-logs"
  sg_name_svc     = "${local.ec2_prefix}-svc-sg"
  sg_name_lb      = "${local.ec2_prefix}-lb-sg"

}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # ID del propietario de la AMI oficial de Ubuntu en AWS
}


resource "aws_instance" "wp" {
  count         = length(var.subnet_ids)
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_pair
  subnet_id     = var.subnet_ids[count.index]
}


resource "aws_launch_template" "foobar" {
  name_prefix   = var.name
  image_id      = data.aws_ami.ubuntu.image_id
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "bar" {
  availability_zones = var.availability_zones
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = aws_launch_template.foobar.id
    version = "$Latest"
  }
}