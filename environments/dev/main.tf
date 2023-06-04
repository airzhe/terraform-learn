provider "aws" {
  region = "us-east-1"
}

module "ec2" {
  source        = "../../modules/ec2"
  instance_type = "t2.micro"
}

module "rds" {
  source         = "../../modules/rds"
  instance_class = "db.t4g.micro"

  db_name        = "${var.env_prefix}test"
  db_username    = "runner"
  db_password    = var.db_password
  prefix         = var.env_prefix

  ec2_security_group_id = module.ec2.security_group_id
}
