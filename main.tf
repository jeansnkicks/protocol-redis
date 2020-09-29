provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "kiva-protocol-terraform-proof-of-concept" {
  bucket = "kiva-protocol-terraform-proof-of-concept"
  acl    = "private"

  tags = {
    Name = "Terraform proof of concept bucket"
    Environment = "Dev"
  }
}
