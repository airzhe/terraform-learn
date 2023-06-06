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
