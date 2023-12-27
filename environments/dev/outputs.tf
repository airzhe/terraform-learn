
output "ec2_instance_public" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2.instance_public
}
/*
output "rds_endpoint" {
  value = module.db.rds_endpoint
}

output "db_instance_password" {
  value     = module.db.db_instance_password
  sensitive = true
}
*/

output "s3_bucket_domain_name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com"
  value       = module.s3-bucket.domain_name
}
