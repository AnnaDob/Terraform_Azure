resource "azurerm_service_plan" "my_app_service_plan" {
  name                = var.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location_app_seevice
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "my_app_service" {
  name                = var.linux_web_app_name
  resource_group_name = var.resource_group_name
  location            = var.location_app_seevice
  service_plan_id     = azurerm_service_plan.my_app_service_plan.id

  identity {
    type  = "SystemAssigned"
  }

  app_settings = {
    DOCKER_REGISTRY_SERVER_PASSWORD = azurerm_key_vault_secret.docker_registry_server_passwd.value
    DOCKER_REGISTRY_SERVER_URL = format("%s.azurecr.io", azurerm_container_registry.acr.name)
    DOCKER_REGISTRY_SERVER_USERNAME = azurerm_container_registry.acr.name
  }

  site_config {

    application_stack {
      docker_image = format("%s.azurecr.io/container_for_image", azurerm_container_registry.acr.name)
      docker_image_tag = "latest"
  }
 }
}