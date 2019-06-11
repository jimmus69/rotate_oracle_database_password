output "rotation_lambda_arn" {
  value = "${aws_lambda_function.rotation_lambda.arn}"
}

output "iam_for_lambda_name" {
  value = "${aws_iam_role.iam_for_lambda.name}"
}
