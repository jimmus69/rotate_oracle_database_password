output "oraclehost" {
  value = "${aws_db_instance.oracle_instance.address}"
}

output "oracleuser" {
  value = "${aws_db_instance.oracle_instance.username}"
}

output "oraclepassword" {
  value = "${random_string.db_password.result}"
}

output "oracledatabase" {
  value = "${aws_db_instance.oracle_instance.name}"
}

output "db_security_groups" {
  value = "${aws_security_group.default.id}"
}
