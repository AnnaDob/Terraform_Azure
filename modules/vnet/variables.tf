variable "location" {
  type    = string
  default = "West Europe"
}

variable "resource_group_name" {
  type    = string
  default = "dev_main_resource_group"
}

variable "storage_account_name" {
  type    = string
  default = "devstorage358"
}

variable "test_vnet_name" {
  type    = string
  default = "test_vnet_name"
}

variable "vnet_address_spase" {
  type    = list(any)
  default = ["10.13.0.0/16"]
}

variable "subnet" {
  type = map(any)
}