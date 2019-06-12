#--- updates existing DB passwords ---

provider "aws" {
    region = "us-west-2"
}

resource "null_resource" "create_db_variables" {
  provisioner "local-exec" {
    command = "python make_terra_var.py"
  }
}

resource "random_string" "password" {
  length = 16
  special = false
  override_special = "/@\" "
}

resource "random_string" "asm_id" {
  length = 16
  special = false
  override_special = "/@\" "
}

output "password" {
  value = "${random_string.password.result}"
}

// //not sure if this is needed 
// resource "aws_lambda_permission" "lambda_permission_secrets_manager" {
//   action        = "lambda:InvokeFunction"
//   principal     = "secretsmanager.amazonaws.com"
//   //function_name = "${aws_lambda_function.rotation_lambda.function_name}"
//   function_name = "password_rotation_lambda"
// }

//Sets passwords for oracle DBs
resource "aws_secretsmanager_secret" "secret_oracle_dbs" {
  count = "${var.count_db_oracle}"
  name = "db-password-${var.list_db_oracle[count.index]}-${random_string.password.result}"
  //rotation_lambda_arn = "${aws_lambda_function.rotation_lambda.arn}"
  //rotation_lambda_arn = "arn:aws:lambda:us-west-2:489585664595:function:password_rotation_lambda"
  
  rotation_rules {
    automatically_after_days = 7
  }
  
    tags = {
    ASM_ID = "${random_string.asm_id.result}"
  }
}

resource "aws_secretsmanager_secret_version" "password_oracle_dbs" {
  count = "${aws_secretsmanager_secret.secret_oracle_dbs.count}"
  secret_id     = "${aws_secretsmanager_secret.secret_oracle_dbs.*.id[count.index]}"
  secret_string = "${random_string.password.result}"
}

//Sets passwords for aurora DBs
resource "aws_secretsmanager_secret" "secret_aurora_dbs" {
  count = "${var.count_db_aurora}"
  name = "db-password-${var.list_db_aurora[count.index]}-${random_string.password.result}"
  //rotation_lambda_arn = "${aws_lambda_function.rotation_lambda.arn}"
  //rotation_lambda_arn = "arn:aws:lambda:us-west-2:489585664595:function:password_rotation_lambda"
  
  rotation_rules {
    automatically_after_days = 7
  }
  
    tags = {
    ASM_ID = "${random_string.asm_id.result}"
  }
}

resource "aws_secretsmanager_secret_version" "password_aurora_dbs" {
  count = "${aws_secretsmanager_secret.secret_aurora_dbs.count}"
  secret_id     = "${aws_secretsmanager_secret.secret_aurora_dbs.*.id[count.index]}"
  secret_string = "${random_string.password.result}"
}