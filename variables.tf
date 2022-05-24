variable "location" {
  type    = string
  default = "West Europe"
}

variable "location_app_seevice" {
  type    = string
  default = "eastus"
}

variable "resource_group_name" {
  type    = string
  default = "dev_main_resource_group"
}

variable "storage_account_name" {
  type    = string
  default = "devmainstorage"
}


variable "key_vault_name" {
  type    = string
  default = "devmainkeyvault"
}


variable "service_plan_name" {
  type = string
  default = "my_app_service_plan"
}

variable "linux_web_app_name" {
  type = string
  default = "devSuperApp"
}


variable "container_registry_name" {
  type = string
  default = "devsuperappregistry"
}

variable "key_vault_secret_app_service_name" {
  type = string
  default = "app-service-name"
}

variable "key_vault_secret_docker_registry_server_passwd" {
  type = string
  default = "docker-registry-server-passwd"
}

variable "nsg_for_vm" {
  type = string
  default = "my_ngp"
}

variable "nsg_for_subnet" {
  type = string
  default = "nsg_subnet"
}

variable "app_service_automation_name" {
  type = string
  default = "app-service-automation"
}

variable "app_service_log_name" {
  type = string
  default = "app-service-log"
}


variable "monitor_app_service_name" {
  type = string
  default = "monitor-app-service"
}