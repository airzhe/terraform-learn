terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-northeast-1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"
}


module "ec2" {
  source        = "../../modules/ec2"
  instance_type = "t2.micro"
  env           = var.env
  ami           = "ami-0dfa284c9d7b2adad"
  shadow_pwd    = var.shadow_pwd
}

module "s3-bucket" {
  source = "../../modules/s3-bucket"
  providers = { aws = aws.us_east_1 }
  env    = var.env
  user   = "runner"
  // 任何必要的变量
}


/*
module "db" {
  source         = "../../modules/rds"
  instance_class = "db.t4g.micro"

  env         = var.env
  db_name     = "${var.env}-test"
  db_username = var.db_user

  ec2_security_group_id = module.ec2.security_group_id
}



module "s3_bucket" {
  source = "../../modules/s3-bucket"

  env  = var.env
  user = var.user
}


module "dynamodb-table" {
  source = "../../modules/dynamodb-table"

  env  = var.env
}*/