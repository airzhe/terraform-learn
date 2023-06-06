output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2-instance.public_ip
}

output "security_group_id" {
  value =  module.ssh_security_group.security_group_id
}

