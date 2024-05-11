variable "environment" {
  description = "The environment in which the resources are being created."
  type        = string
}

variable "db_name" {
  description = "The name of the database to create"
  type        = string
  default     = "wordpress"

}

variable "username" {
  default     = "wp_user"
  type        = string
  description = "Wordpress DB User"

}

variable "password" {
  default     = ""
  type        = string
  description = "Wordpress DB Password"
}


variable "availability_zones" {
  description = "A list of availability zones to use for the ASG"
  type        = list(string)
  default     = []
}

variable "identifier" {
  description = "The identifier of the RDS cluster"
  type        = string
  default     = "wordpress-db"
}

variable "engine" {
  description = "The engine to use for the RDS cluster"
  type        = string
  default     = "postgres"
}


variable "database_name" {
  description = "The name of the database in the RDS cluster"
  type        = string
  default     = "wordpress"
}

variable "instance_class" {
  description = "The instance class to use for the RDS cluster"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "The amount of storage to allocate for the RDS cluster"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "The maximum amount of storage to allocate for the RDS cluster"
  type        = number
  default     = 100
}

variable "port" {
  description = "The port to use for the RDS cluster"
  type        = number
  default     = 5432
}

variable "parameter_group_name" {
  default = "default.postgres16"
}

variable "vpc_id" {
  description = ""
  type        = string
}

variable "source_security_group_id" {
  description = "The security group to use as the source for the RDS cluster"
  type        = string
}

variable "security_groups" {
  description = "The security groups to use for the RDS cluster"
  type        = list(string)
  default     = []
}

variable "subnet_group_name" {
  description = "The name of the subnet group to use for the RDS cluster"
  type        = string
  default     = "default"
}

variable "replica_count" {
  description = "The number of replicas to create for the RDS cluster"
  type        = number
  default     = 1
}

variable "dns_zone_id" {
  description = "The ID of the DNS zone to use for the RDS cluster"
  type        = string
}