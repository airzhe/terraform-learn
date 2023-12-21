variable "env" {
  description = "Environment prefix for resources"
  default     = "dev"
}

variable "user" {
  description = "Environment prefix for resources"
  default     = "airzhe"
}

variable "db_user" {
  description = "The username for the RDS instance"
  type        = string
}

variable "shadow_pwd" {
  type        = string
  description = "Shadowsocks Server's password"
}