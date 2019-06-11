variable "region" {
  type = "string"
}

variable "environment" {
  default = "test"
  type    = "string"
}

variable "db_name" {
  type = "string"
}

variable "username" {
  type = "string"
}

variable "instance_class" {
  default = "String"
}

variable "rotation_lambda_arn" {
  default = "String"
}
