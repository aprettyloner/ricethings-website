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
## Note: 'bucket1' is a REFERENCE LABEL. Not actual name in S3.
## To do so, add an ATTRIBUTE (or use outputs)
resource "aws_s3_bucket" "bucket1" {
    bucket = "bucket1"
}

output "bucket_info" {
    value = aws_s3_bucket.bucket1
}

## Note: need to use "data." prefix to access data
output  "aws_caller_info" {
    value = data.aws_caller_identity.current
}

output "aws_availability_info" {
    value = data.aws_availability_zones.available
}

#Data Sources
data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
    state = "available"
}