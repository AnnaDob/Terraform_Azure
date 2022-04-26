# resource "azurerm_storage_account_network_rules" "my_ip_rules" {
#   storage_account_id = azurerm_storage_account.my_ip_rules.id

#   default_action             = "Allow"
#   ip_rules                   = ["195.160.234.124"]
#   virtual_network_subnet_ids = [module.vnet.subnet["subnet_1"].id]
# }


