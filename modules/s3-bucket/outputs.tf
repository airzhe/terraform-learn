output "domain_name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com"
  value = module.s3_bucket.s3_bucket_bucket_domain_name
}
