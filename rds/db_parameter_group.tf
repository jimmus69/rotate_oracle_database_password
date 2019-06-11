resource "aws_db_parameter_group" "oracle_parameters" {
  name   = "${var.db_name}"
  family = "oracle-se-11.2"

  tags = {
    "Name" = "Oracle param group for ${var.db_name}"
  }
}
