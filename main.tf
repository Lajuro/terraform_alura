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

  vpc_security_group_ids = [ "${aws_security_group.acesso_ssh.id}" ]
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

resource "aws_instance" "dev4" {
  ami           = "ami-06e46074ae430fba6"
  instance_type = "t2.micro"
  key_name      = "terraform-aws"

  tags = {
    Name = "dev4 for S3 Bucket"
  }

  vpc_security_group_ids = [ "${aws_security_group.acesso_ssh.id}" ]
  depends_on = [
    aws_s3_bucket.dev4
  ]
}

resource "aws_instance" "dev5" {
  ami           = "ami-06e46074ae430fba6"
  instance_type = "t2.micro"
  key_name      = "terraform-aws"

  tags = {
    Name = "dev5"
  }

  vpc_security_group_ids = [ "${aws_security_group.acesso_ssh.id}" ]
}

resource "aws_s3_bucket" "dev4" {
  bucket = "camargor-dev4"
  acl = "private"

  tags = {
    Name = "camargor-dev4"
  }
}
