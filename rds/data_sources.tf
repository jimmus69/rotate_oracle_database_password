# Remote state
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket = "jamesdadd-goldmansachs-bucket-test-${var.region}"
    key    = "test/vpc"
    region = "${var.region}"
  }
}
