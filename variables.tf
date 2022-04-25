variable "location" {
  type = string
  default = "West Europe"
}

variable "resource_group_name" {
  type = string
  default = "dev_main_resource_group"
}

variable "storage_account_name" {
  type = string
  default = "devstorage358"
}

variable "test_vnet_name" {
  type = string
  default = "test_vnet_name"
}

variable "vnet_address_spase" {
  type = list(any)
  default = ["10.13.0.0/16"]
}

variable "subnets" {
  type = map(any)
  default = {
    subnet_1 = {
        name = "subnet_1"
        address_prefixes = ["10.13.1.0/24"]
    }
    subnet_2 = {
        name = "subnet_2"
        address_prefixes = ["10.13.2.0/24"]
    }
  }
}