#--- update_db_password/variables.tf---
variable "list_db_oracle" {
	default = ["deleteme","testdatabase"
	]
}
variable "list_db_aurora" {
	default = ["anotheraurouradb","coldplaydb-instance-identifier","mydbinstance"
	]
}
variable "count_db_oracle" {
	default = 2
}
variable "count_db_aurora" {
	default = 3
}
variable "oracle_db_address" {
	default = ["deleteme.cr4zhtk4gzfg.us-west-2.rds.amazonaws.com","testdatabase.cr4zhtk4gzfg.us-west-2.rds.amazonaws.com"
	]
}
variable "aurora_db_address" {
	default = ["anotheraurouradb.cr4zhtk4gzfg.us-west-2.rds.amazonaws.com","null","mydbinstance.cr4zhtk4gzfg.us-west-2.rds.amazonaws.com"
	]
}
variable "oracle_db_username" {
	default = ["deleteme","testdatabase"
	]
}
variable "aurora_db_username" {
	default = ["anotheraurouradb","coldplaysername","mydbinstance"
	]
}