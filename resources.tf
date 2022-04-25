terraform {
  backend "azurerm" {
    resource_group_name  = "dev_main_resource_group"
    storage_account_name = "devstorage358"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}


resource "azurerm_virtual_network" "example" {
  name                = var.test_vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_spase
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnets
  resource_group_name = var.resource_group_name
  virtual_network_name = var.test_vnet_name
  name = each.value["name"]
  address_prefixes = each.value["address_prefixes"]
}