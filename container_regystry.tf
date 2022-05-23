# data "azuread_client_config" "current" {}

resource "azurerm_container_registry" "acr" {
  name                = "devsuperappregistry"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_role_assignment" "acr_role" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_linux_web_app.my_app_service.identity[0].principal_id
}

# output "azuread_client_config" {
#   value = data.azuread_client_config.current.client_id
# }


