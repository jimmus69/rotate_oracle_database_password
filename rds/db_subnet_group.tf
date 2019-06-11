resource "aws_db_subnet_group" "oracle_group" {
  name       = "${var.db_name}"
  subnet_ids = ["${data.terraform_remote_state.vpc.private_subnets}"]

  tags {
    "name" = "${var.db_name}"
  }
}
