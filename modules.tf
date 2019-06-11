module "rds" {
  source              = "./rds"
  db_name             = "${var.db_name}"
  instance_class      = "${var.instance_class}"
  username            = "${var.username}"
  region              = "${var.region}"
  rotation_lambda_arn = "${module.lambda_base.rotation_lambda_arn}"
}

module "lambda_base" {
  source             = "./lambda_base"
  db_name            = "${var.db_name}"
  username           = "${var.username}"
  region             = "${var.region}"
  db_security_groups = "${module.rds.db_security_groups}"
}

module "lambda_configure" {
  source              = "./lambda_configure"
  db_name             = "${var.db_name}"
  username            = "${var.username}"
  region              = "${var.region}"
  db_security_groups  = "${module.rds.db_security_groups}"
  rotation_lambda_arn = "${module.lambda_base.rotation_lambda_arn}"
  iam_for_lambda_name = "${module.lambda_base.iam_for_lambda_name}"
}
