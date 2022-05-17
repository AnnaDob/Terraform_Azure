resource "azurerm_service_plan" "my_app_service_plan" {
  name                = "my_app_service_plan"
  resource_group_name = var.resource_group_name
  location            = var.location_app_seevice
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "my_app_service" {
  name                = "devSuperApp"
  resource_group_name = var.resource_group_name
  location            = var.location_app_seevice
  service_plan_id     = azurerm_service_plan.my_app_service_plan.id

  site_config {

    application_stack {
    docker_image = format("%s.azurecr.io/container_for_image", azurerm_container_registry.acr.name)
    docker_image_tag = "latest"
  }
 }
}
