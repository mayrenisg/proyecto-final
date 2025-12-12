variable "vnet_name" {}
variable "address_space" { type = list(string) }
variable "public_subnet_name" {}
variable "public_subnet_cidr" {}
variable "location" { default = "westus2" }
variable "resource_group_name" { default = "myTFResourceGroup" }
