variable "env_prefix" {
  description = "Environment prefix for resources"
  default     = "dev"
}


variable "db_password" {
  description = "The password for the RDS instance"
  type        = string
  sensitive   = true
}
