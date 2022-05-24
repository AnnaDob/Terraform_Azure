resource "azurerm_automation_account" "app_service_automation" {
  name                = var.app_service_automation_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Basic"
}

resource "azurerm_log_analytics_workspace" "app_service_log" {
  name                = var.app_service_log_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_monitor_diagnostic_setting" "monitor_app_service" {
  name                       = var.monitor_app_service_name
  target_resource_id         = azurerm_linux_web_app.my_app_service.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.app_service_log.id

  log {
    category = "AppServiceAppLogs"
    enabled  = true
  }

  log {
    category = "AppServiceAntivirusScanAuditLogs"
    enabled  = true
  }

  log {
    category = "AppServiceHTTPLogs"
    enabled  = true
  }

  log {
    category = "AppServiceConsoleLogs"
    enabled  = true
  }

  log {
    category = "AppServiceFileAuditLogs"
    enabled  = true
  }

  log {
    category = "AppServiceAuditLogs"
    enabled  = true
  }

  log {
    category = "AppServiceIPSecAuditLogs"
    enabled  = true
  }

  log {
    category = "AppServicePlatformLogs"
    enabled  = true
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}