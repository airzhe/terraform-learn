output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.myinstance.public_ip
}

output "security_group_id" {
  value = aws_security_group.allow_ssh.id
}

