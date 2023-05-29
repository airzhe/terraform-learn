provider "aws" {
  region = "us-east-1"
}

module "ec2" {
  source = "../../modules/ec2"
}

module "rds" {
  source = "../../modules/rds"

  db_name     = "${var.env_prefix}test"
  db_username = "runner"
  db_password = var.db_password
  prefix      = var.env_prefix

  ec2_security_group_id = module.ec2.security_group_id
}