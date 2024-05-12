variable "environment" {
  description = "The environment in which the resources are being created."
  type        = string
}

variable "availability_zones" {
  description = "A list of availability zones to use."
  type        = list(string)

}
variable "instance_type" {
  description = "The type of instance to start."
  default     = "t2.micro"
}
variable "name" {
  description = "The name for the resource."
  type        = string
}

variable "ami" {
  description = "The Amazon Machine Image ID."
  default     = ""
  type        = string
}

variable "key_pair" {
  description = "The name of the key pair to use."
  type        = string
}

variable "alb_subnet_ids" {
  description = "A list of subnet IDs to associate with."
  type        = list(string)
}

variable "instances_subnet_ids" {
  description = "A list of subnet IDs to associate with."
  type        = list(string)
}

variable "efs_subnet_ids" {
  description = "A list of subnet IDs to associate with."
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the Virtual Private Cloud to associate with."
  type        = string
}

variable "port" {
  description = "The port on which the application/service should run."
  default     = 80
  type        = number
}

variable "ec2_prefix" {
  description = "Prefix to prepend to EC2 instance names/tags."
  default     = ""
  type        = string
}

variable "alb_prefix" {
  description = "Prefix to prepend to Application Load Balancer names/tags."
  default     = ""
  type        = string
}

variable "expose" {
  description = "Whether or not to expose the resource publicly."
  default     = true
  type        = bool
}

variable "alb_logs" {
  description = "Whether or not to enable logs for the Application Load Balancer."
  default     = true
  type        = bool
}

variable "hostname" {
  description = "Hostname"
  default     = "www"
  type        = string
}

variable "route53_zone_id" {
  description = "zone_id"
  default     = ""
  type        = string
}

variable "desired_capacity" {
  description = "Auto Scaling Group Desired Capacity"
  default     = 1
  type        = number
}
variable "max_size" {
  description = "Auto Scaling Group Max Size"
  default     = 1
  type        = number
}
variable "min_size" {
  description = "Auto Scaling Group Min Size"
  default     = 1
  type        = number
}

variable "security_groups" {
  description = "List of security group IDs to associate with the instance."
  default     = []
  type        = list(string)
}

variable "data_security_groups" {
  description = "List of security group IDs to associate with the instance."
  default     = []
  type        = list(string)
}

