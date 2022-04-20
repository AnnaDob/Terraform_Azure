locals {
  setup_name = "dev"
}


// Configure the Resource Group
resource "azurerm_resource_group" "main" {
  name     = "${local.setup_name}_main_resource_group"
  location = "West Europe"
}

// Configure the Storage Account
resource "azurerm_storage_account" "dev" {
  name                     = "${local.setup_name}storage358"
  resource_group_name      = azurerm_resource_group.main.name

  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}