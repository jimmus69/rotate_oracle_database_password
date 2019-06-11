resource "aws_db_instance" "oracle_instance" {
  identifier           = "${var.db_name}"
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "oracle-se"
  engine_version       = "11.2.0.4.v20"
  instance_class       = "${var.instance_class}"
  name                 = "${var.db_name}"
  username             = "${var.username}"
  password             = "${random_string.db_password.result}"
  db_subnet_group_name = "${aws_db_subnet_group.oracle_group.id}"
  parameter_group_name = "${aws_db_parameter_group.oracle_parameters.id}"
  publicly_accessible  = false
  skip_final_snapshot  = true

  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  tags {
    "Name" = "${var.db_name}"
  }
}
