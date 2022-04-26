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


# Create public IPs
resource "azurerm_public_ip" "linux_vm_public_ip" {
  name                = "linux_vm_public_ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

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
    source_address_prefix      = "195.160.234.124"
    destination_address_prefix = "*"
  }
}

# Create network interface
resource "azurerm_network_interface" "my_nic" {
  name                = "my_nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "my_nic_configuration"
    subnet_id                     = module.vnet.subnet["subnet_1"].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_vm_public_ip.id
  }
}

# # Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "connect_nic_ngp" {
  network_interface_id      = azurerm_network_interface.my_nic.id
  network_security_group_id = azurerm_network_security_group.my_ngp.id
}

# Create (and display) an SSH key
resource "tls_private_key" "vm_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# # Create virtual machine
resource "azurerm_virtual_machine" "linux_vm" {
  name                  = "linux_vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.my_nic.id]
  vm_size               = "Standard_E2bds_v5"
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}