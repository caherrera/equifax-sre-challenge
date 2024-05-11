terraform {
  backend "remote" {
    organization = "carlos-herrera"
    workspaces {
      name = "equifax-aws"
      
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.48.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Owner       = "Carlos Herrera"
      Environment = var.environment
      App         = var.name
      Terraform   = "true"
    }
  }
}