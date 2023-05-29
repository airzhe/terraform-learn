variable "db_username" {
  type        = string
  description = "Username for the RDS database"
}

variable "db_password" {
  type        = string
  description = "Password for the RDS database"
}

variable "db_name" {
  type        = string
  description = "database name"
}

variable "prefix" {
  type        = string
  description = "prefix"
}

variable "allocated_storage" {
  description = "The allocated storage in gibibytes for the RDS instance"
  type        = number
  default     = 10
}


variable "ec2_security_group_id" {
  description = "EC2 security group ID"
  type        = string
}