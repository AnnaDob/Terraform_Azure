terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.2.0"
    }
  }
}

// Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# provider "azurerm" {
#   features {}
#   subscription_id = "f64f6cc2-6445-44ed-84a5-1430eb7ffff2"
#   client_id       = "c1e3cd90-edb0-414d-95cb-d29a434758da"
#   client_secret   = "Lcu8Q~FLWx3Vz4NxQWeZM5kwFn8_EHMiq.0F2brP"
#   tenant_id       = "df94c9ad-a475-439b-81f9-427edb2b4a3e"
# }

data "azurerm_client_config" "current" {
}

output "account_id" {
  value = data.azurerm_client_config.current.client_id
}

