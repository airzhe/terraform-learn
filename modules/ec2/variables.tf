variable "instance_type" {
  type        = string
  description = "instance_class"
}

variable "env" {
  type        = string
  description = "env"
}

variable "ami" {
  type        = string
  description = "ami"
}

variable "shadow_pwd" {
  type        = string
  description = "Shadowsocks Server's password"
}