module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "5.9.0"

  identifier        = "${var.env}-postgres"
  engine            = "postgres"
  engine_version    = "15"
  family            = "postgres15"
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  db_name           = "test"
  username          = var.db_username

  vpc_security_group_ids      = [module.postgresql_security_group.security_group_id]
  allow_major_version_upgrade = true
  maintenance_window          = "Mon:00:00-Mon:03:00"
  backup_window               = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  monitoring_interval    = "30"
  monitoring_role_name   = "MyRDSMonitoringRole"
  create_monitoring_role = true

  tags = {
    Owner       = "runner"
    Environment = var.env
  }

  # Database Deletion Protection
  deletion_protection = true

}

data "aws_vpc" "default" {
  default = true
}

module "postgresql_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "postgres"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = data.aws_vpc.default.id

  ingress_with_source_security_group_id = [
    {
      rule                     = "postgresql-tcp"
      source_security_group_id = var.ec2_security_group_id
    }
  ]
}
