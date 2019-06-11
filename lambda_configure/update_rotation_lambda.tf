data "template_file" "lambda_permissions_policy" {
  template = "${file("${path.module}/lambda_permissions_policy.json.tpl")}"

  vars {
    lambda_arn = "${var.rotation_lambda_arn}"
  }
}

resource "aws_iam_role_policy" "attach_permissions" {
  role   = "${var.iam_for_lambda_name}"
  policy = "${data.template_file.lambda_permissions_policy.rendered}"
}
