resource "random_string" "db_password" {
  length  = 24
  lower   = true
  upper   = true
  number  = true
  special = false
}

resource "random_string" "secret_name_suffix" {
  length  = 5
  lower   = false
  upper   = false
  number  = true
  special = false
}

resource "aws_secretsmanager_secret" "db_password" {
  name                = "db-password-${random_string.secret_name_suffix.result}"
  rotation_lambda_arn = "${var.rotation_lambda_arn}"

  rotation_rules {
    automatically_after_days = 1
  }
}

resource "aws_secretsmanager_secret_version" "db_password_version" {
  secret_id = "${aws_secretsmanager_secret.db_password.id}"

  secret_string = "${jsonencode(
    map(
    "engine", "postgres",
    "host", "${aws_db_instance.oracle_instance.address}",
    "user_name", "${aws_db_instance.oracle_instance.username}",
    "password", "${random_string.db_password.result}",
    "dbname", "${aws_db_instance.oracle_instance.name}"
    ))}"
}
