resource "azurerm_key_vault" "my_key_vault" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

  key_permissions = [
      "Create",
      "Get",
      "List"
    ]

  secret_permissions = [
      "Set",
      "Get",
      "List"
    ]

  storage_permissions = [
     "Set",
     "List",
     "Get"
    ]
  }
}

resource "azurerm_key_vault_secret" "app_service_name" {
  name         = var.key_vault_secret_app_service_name
  value        = azurerm_linux_web_app.my_app_service.name
  key_vault_id = azurerm_key_vault.my_key_vault.id
}

resource "azurerm_key_vault_secret" "docker_registry_server_passwd" {
  name         = var.key_vault_secret_docker_registry_server_passwd
  value        = azurerm_container_registry.acr.admin_password
  key_vault_id = azurerm_key_vault.my_key_vault.id
}