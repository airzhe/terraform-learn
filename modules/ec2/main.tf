module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.1.0"

  name                    = "runner-node"
  ami                     = "ami-0715c1897453cabd1"
  instance_type           = var.instance_type
  key_name                = module.key_pair.key_pair_name
  monitoring              = true
  vpc_security_group_ids  = [module.ssh_security_group.security_group_id]
  disable_api_termination = true

  user_data = <<-EOF
#!/bin/bash
sudo yum update -y
sudo yum install docker -y
sudo service docker start
sudo chkconfig docker on
sudo usermod -a -G docker ec2-user
newgrp docker
docker run -d -p 80:80 nginx
EOF

  tags = {
    Terraform   = "true"
    Environment = var.env
    ForceNew    = "${timestamp()}"
  }

}

#ssh-keygen -t rsa -b 4096
module "key_pair" {
  source     = "terraform-aws-modules/key-pair/aws"
  key_name   = "runner"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC7DmwWIQ75Gn8JoIqdbB0EIdCKHTZ00FSS4OXM/fUdIhKxOWt8ltpnlbyiuGVXROcOq6vx+TG8ipIczXuhC1+TP991EtXEs1xbVUo08YRfUMnD2toTOXSfSdPYYJk8PvB4fd592hUfYEMh9XfhQBT/pwVbNQ9LcPDXbdlWRHzBke82zOtkxdH6/zbFf3Pm831ZTzOVIdmwdmQ0dwFWWyKtzS4MquVMVDfqazaMqeaqyTJcfHWlkJYThgSArFnopz5ZAqjTqd1i16jmt/mQVgjiaevvnMzVwvNUXmxlT2Gmh583Li2z0aZ1Fyr06gAaaR7gf29c33VL509fe80ngG8lz1Z2IBN5IPYA3OfqAgmBjhixMNprpglsrW9pewVv5x/G7PlmnKdZQB7Jy0MXrJkgCA8qmVljDbYmUufBvr0+TzYvPcXYhcmyzaX6p8du6VIsDHPwFPojGtBSyc3MJvdpXY6/Q/vEKuyjUbwatAIEUVTLgp70RADMyje+0JDJXaf1MpXXG+7BIziv/fm+4ka7H0rY4dMuJAKsP69oeTK+KqxiRfwM+/CY26c5sDwDLhtwMUjDzkx4+lmmUhOKMRGmH933o/Z8ofuh4n/dAe1j+aCkXmMmJczbbd4Moa697kU7tCvqrqqzdslZbomYKaEUpotqBFUBEQ4QbDN+myn1Pw== runner@MacBook-Pro.local"
}

data "aws_vpc" "default" {
  default = true
}

module "ssh_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "allow_ssh"
  description = "Security group for SSH and HTTP/HTTPS access from all IP addresses in default VPC"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh ports"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}
