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

provider "aws" {
  alias = "us-east-2"
  region  = "us-east-2"
}

resource "aws_instance" "dev" {
  count = 1
  ami           = var.amis["us-east-1"]
  instance_type = "t2.micro"
  key_name      = var.key_name

  tags = {
    Name = "My Instance ${count.index}"
  }

  vpc_security_group_ids = [ "${aws_security_group.acesso_ssh.id}" ]
}

resource "aws_instance" "dev2" {
  provider = aws.us-east-2
  ami = var.amis["us-east-2"]
  instance_type = "t2.micro"
  key_name      = var.key_name
  tags = {
    Name = "dev2"
  }

  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"]
  depends_on = [ aws_dynamodb_table.dynamodb-qa ]
}

resource "aws_s3_bucket" "dev4" {
  bucket = "camargor-dev4"

  tags = {
    Name = "camargor-dev4"
  }
}

resource "aws_dynamodb_table" "dynamodb-qa" {
  provider = aws.us-east-2
  name           = "GameScores"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }

  attribute {
    name = "TopScore"
    type = "N"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  global_secondary_index {
    name               = "GameTitleIndex"
    hash_key           = "GameTitle"
    range_key          = "TopScore"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["UserId"]
  }

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }
}
