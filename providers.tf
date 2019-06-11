provider "aws" {
  region  = "${var.region}"
  version = "2.12"
}

terraform {
  require_version = "> 0.11.7"

  backend "s3" {
    bucket  = "jamesdadd-goldmansachs-bucket-test-us-east-1"
    key     = "test/rds"
    region  = "us-east-1"
    encrypt = "true"
  }
}
