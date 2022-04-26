# Remote backend
terraform {
  backend "azurerm" {
    resource_group_name  = "dev_main_resource_group"
    storage_account_name = "devstorage358"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

# Create vnet and subnets via module
module "vnet" {
  source = "./modules/vnet"
  subnet = {
    subnet_1 = {
      name             = "subnet_1"
      address_prefixes = ["10.13.1.0/24"]
    }
    subnet_2 = {
      name             = "subnet_2"
      address_prefixes = ["10.13.2.0/24"]
    }
  }
}