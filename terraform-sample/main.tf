#Terraform
terraform {
    required_version = ">=0.12.0"
}

#Provider
provider "aws" {
    version = "~> 2.0"
    region = "us-east-1"
    shared_credentials_file = "~/.aws/creds"
}

#Resource
## Note: 'bucekt1' is a REFERENCE LABEL. Not actual name in S3.
## To do so, add an ATTRIBUTE
resource "aws_s3_bucket" "bucket1" {
    bucket = "bucket1"
}

#Data Sources
data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
    state = "available"
}