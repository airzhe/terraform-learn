resource "aws_s3_bucket" "this1" {
  bucket = "${var.env_prefix}-my-bucket"
}
