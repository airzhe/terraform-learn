
/*
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  //S3桶的名称是全球唯一的，所以你需要确认你的桶名称不与现有的桶冲突。
  bucket = "${var.env}-${var.user}-s3-bucket"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}
*/

data "aws_caller_identity" "current" {}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "heylisa"

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"
  expected_bucket_owner    = data.aws_caller_identity.current.account_id
  acl                      = "public-read"

  attach_policy = true
  policy = file("${path.module}/my-bucket-policy.json")

  cors_rule = [
    {
      allowed_headers = ["*"]
      allowed_methods = ["GET"]
      allowed_origins = ["https://my-app.domain.com"]
      max_age_seconds = 3000
    }
  ]
}


resource "aws_s3_bucket" "airzhe" {
  bucket = "airzhe"
}
