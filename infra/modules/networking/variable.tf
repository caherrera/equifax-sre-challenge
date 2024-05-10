variable "name" {
  default = "project"
}

variable "use_nat" {
  default = true
  type    = bool
}

variable "vpc_id" {
  description = ""
  type        = string
  default     = ""
}

variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  default     = 2
}


variable "netnum_offset" {
  description = "Offset for separate private and public subnets"
  default     = null
}

variable "newbits" {
  default = 8
}

########################################
# Public Subnet settings               #
########################################
variable "public_cidr_block" {
  default = ""
  type    = string
}

variable "public_netnum_offset" {
  description = "Offset for public subnets"
  default     = 120
}

variable "public_tags" {
  default = {}
}


########################################
# Private Subnet settings              #
########################################
variable "private_cidr_block" {
  default = ""
  type    = string
}

variable "private_netnum_offset" {
  description = "Offset for private subnets"
  default     = 160
}

variable "private_tags" {
  default = {}
}

########################################
# Database Subnet settings             #
########################################
variable "database_cidr_block" {
  default = ""
  type    = string
}

variable "database_netnum_offset" {
  description = "Offset for database subnets"
  default     = 200
}

variable "database_tags" {
  default = {}
}