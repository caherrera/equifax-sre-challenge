packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
    ansible = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "wordpress-ubuntu"
  instance_type = "t2.micro"
  region        = "us-east-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name    = "wordpress-ubuntu-{{timestamp}}"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  #   provisioner "file" {
  #     source      = "roles"
  #     destination = "/tmp/roles"
  #   }
  #   provisioner "file" {
  #     source      = "playbook.yml"
  #     destination = "/tmp/playbook.yml"
  #   }
  #
  #   provisioner "file" {
  #     source      = "hosts.ini"
  #     destination = "/tmp/hosts.ini"
  #   }
  #
  #   provisioner "shell" {
  #     inline = [
  #       "sudo apt-get update",
  #       "sudo apt-get install -y ansible",
  #       "cd /tmp",
  #     ]
  #   }

  provisioner "ansible" {
    playbook_file = "playbook.yml"
#     user          = "/"
  }


}

