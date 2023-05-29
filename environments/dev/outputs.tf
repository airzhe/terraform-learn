output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2.instance_public_ip
}