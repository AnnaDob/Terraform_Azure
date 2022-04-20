locals {
  setup_name = "terra"
}


// Configure the Resource Group
resource "azurerm_resource_group" "terra_resource_group" {
  name     = "${local.setup_name}_resource_group"
  location = "West Europe"
}

// Configure the Storage Account
resource "azurerm_storage_account" "terra_storageaccount" {
  name                     = "${local.setup_name}storageaccount2222"
  resource_group_name      = azurerm_resource_group.terra_resource_group.name

  location                 = azurerm_resource_group.terra_resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}