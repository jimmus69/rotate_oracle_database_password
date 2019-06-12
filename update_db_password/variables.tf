#--- update_db_password/variables.tf---
variable "list_db_oracle" {
	default = ["deleteme","testdatabase"
	]
}
variable "list_db_aurora" {
	default = ["anotheraurouradb","mydbinstance"
	]
}
variable "count_db_oracle" {
	default = 2
}
variable "count_db_aurora" {
	default = 2
}