resource "aws_iam_role" "iam_for_lambda" {
  name = "${var.db_name}_iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "AllowLambdaService"
    }
  ]
}
EOF
}

resource "aws_cloudwatch_log_group" "rotation_lambda_log_group" {
  name              = "/aws/lambda/password_rotation_lambda"
  retention_in_days = 14
}

data "template_file" "lambda_base_permissions_policy" {
  template = "${file("${path.module}/lambda_base_permissions_policy.json.tpl")}"
}

resource "aws_iam_policy" "lambda_base_permissions" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = "${data.template_file.lambda_base_permissions_policy.rendered}"
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = "${aws_iam_role.iam_for_lambda.name}"
  policy_arn = "${aws_iam_policy.lambda_base_permissions.arn}"
}

resource "aws_lambda_permission" "lambda_permission_secrets_manager" {
  action        = "lambda:InvokeFunction"
  principal     = "secretsmanager.amazonaws.com"
  function_name = "${aws_lambda_function.rotation_lambda.function_name}"
}

data "archive_file" "rotation_lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda_source"
  output_path = "${path.module}/rotation_lambda.zip"
}

resource "aws_lambda_function" "rotation_lambda" {
  filename         = "${path.module}/rotation_lambda.zip"
  source_code_hash = "${data.archive_file.rotation_lambda_zip.output_base64sha256}"
  function_name    = "password_rotation_lambda"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "rotation_lambda.lambda_handler"

  vpc_config {
    subnet_ids         = ["${data.terraform_remote_state.vpc.private_subnets}"]
    security_group_ids = ["${var.db_security_groups}"]
  }

  runtime = "python2.7"
}
