# Create Network Security Group and rule
resource "azurerm_network_security_group" "my_ngp" {
  name                = "my_ngp"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "195.160.234.123"
    destination_address_prefix = "*"
  }
}