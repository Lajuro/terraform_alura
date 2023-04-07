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
  ami           = "ami-06e46074ae430fba6"
  instance_type = "t2.micro"
  key_name      = "terraform-aws"

  tags = {
    Name = "Terraform App"
  }
}
