resource "azurerm_virtual_network" "my_vnet" {
  name                = var.my_vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_spase
}

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnet
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.my_vnet_name
  name                 = each.value["name"]
  address_prefixes     = each.value["address_prefixes"]
}