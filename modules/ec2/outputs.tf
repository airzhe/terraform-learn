output "instance_public" {
  description = "Public IP of the EC2 instance"
  value = {
    ip  = module.ec2-instance.public_ip
    dns = module.ec2-instance.public_dns
  }
}

output "security_group_id" {
  value = module.ssh_security_group.security_group_id
}