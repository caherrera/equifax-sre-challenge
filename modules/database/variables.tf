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
  default     = ["us-east-2a", "us-east-2b", "us-east-2c"]
}

variable "cluster_identifier" {
  description = "The identifier of the RDS cluster"
  type        = string
  default     = "wordpress-db"
}

variable "engine" {
  description = "The engine to use for the RDS cluster"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "The version of the engine to use for the RDS cluster"
  type        = string
  default     = "8.0"
}

variable "database_name" {
  description = "The name of the database in the RDS cluster"
  type        = string
  default     = "wordpress"
}

variable "family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = "mysql8.0"
}

variable "major_engine_version" {
  description = "The major version of the engine to use for the RDS cluster"
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "The instance class to use for the RDS cluster"
  type        = string
  default     = "db.t4g.large"
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
  default     = 3306
}

variable "parameter_group_name" {
  default = "default.mysql8.0"
}

variable "vpc_id" {
  description = ""
  type        = string
}

variable "subnet_ids" {
  description = "Subnet"
  type        = string
}