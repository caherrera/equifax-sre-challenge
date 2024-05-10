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
