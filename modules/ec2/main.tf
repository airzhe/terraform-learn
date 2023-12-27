module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.1.0"

  name                    = "runner-node"
  ami                     = var.ami
  instance_type           = var.instance_type
  key_name                = module.key_pair.key_pair_name
  monitoring              = true
  vpc_security_group_ids  = [module.ssh_security_group.security_group_id]
  disable_api_termination = true
  user_data = templatefile("${path.module}/user_data.sh", {
    password = var.shadow_pwd
  })
  tags = {
    Terraform   = "true"
    Environment = var.env
    #ForceNew    = "${timestamp()}"
  }
}

#ssh-keygen -t rsa -b 4096
module "key_pair" {
  source     = "terraform-aws-modules/key-pair/aws"
  key_name   = "runner01"
  public_key = file("${path.module}/public_key.pub")
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
    },
    {
      from_port   = 5000 # 容器的端口号（ssserver-rust）
      to_port     = 5000 # 容器的端口号（ssserver-rust）
      protocol    = "tcp"
      description = "Shadowsocks Server (ssserver-rust) UDP ports"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 5000 # 容器的端口号（ssserver-rust）
      to_port     = 5000 # 容器的端口号（ssserver-rust）
      protocol    = "udp"
      description = "Shadowsocks Server (ssserver-rust) UDP ports"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 3120 # 容器的端口号（ssserver-rust）
      to_port     = 3120 # 容器的端口号（ssserver-rust）
      protocol    = "tcp"
      description = "Shadowsocks Client (ssserver-rust) Tcp ports"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}
