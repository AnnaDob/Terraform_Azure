# Generate rundom password for VM
resource "random_password" "password" {
  length = 16
  special = true
  override_special = "_%@"
}

# Create public IPs
resource "azurerm_public_ip" "linux_vm_public_ip" {
  name                = "linux_vm_public_ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
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

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "connect_nic_ngp" {
  network_interface_id      = azurerm_network_interface.my_nic.id
  network_security_group_id = azurerm_network_security_group.my_ngp.id
}

# Create (and display) an SSH key
resource "tls_private_key" "vm_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create virtual machine
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
    admin_username = "my_vm_admin"
    admin_password = random_password.password.result
 }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}