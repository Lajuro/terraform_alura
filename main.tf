terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "dev" {
  count = 3
  ami           = "ami-06e46074ae430fba6"
  instance_type = "t2.micro"
  key_name      = "terraform-aws"

  tags = {
    Name = "My Instance ${count.index}"
  }

  vpc_security_group_ids = [ "sg-03d909a79e4dbaa31" ]
}

resource "aws_security_group" "acesso_ssh" {
  name        = "acesso_ssh"
  description = "Acesso SSH"

  ingress {
    description      = "Acesso SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["YOUR_IP"] # Preencher com o seu IP IPv4
  }

  tags = {
    Name = "acesso_ssh"
  }
}
