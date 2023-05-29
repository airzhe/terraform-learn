resource "aws_db_instance" "postgresql" {
  allocated_storage      = var.allocated_storage
  engine                 = "postgres"
  engine_version         = "13.6"
  instance_class         = "db.t4g.large"
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.allow_db.id]

  tags = {
    Name = "runner-rds"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_security_group" "allow_db" {
  name        = "allow_db"
  description = "Allow inbound traffic to DB"
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.ec2_security_group_id]
  }
}