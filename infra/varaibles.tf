variable "region" {
  description = "The AWS region to deploy to"
  default     = "us-east-2"
}

variable "domain" {
  description = "The domain to deploy to"
  default     = "my-wordpress-app.com"
}

variable "name" {
  description = "The name of the application"
  default     = "wordpress"
}

variable "environment" {
  description = "The environment to deploy to"
  default     = "dev"
}

variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  default     = 2
}

variable "ami" {
  description = "The AMI to use for the EC2 instances"
  default     = "wordpress-ubuntu"
}