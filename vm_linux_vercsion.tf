# # Create public IPs
# resource "azurerm_public_ip" "linux_vm_public_ip_new" {
#   name                = "linux_vm_public_ip_new"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   allocation_method   = "Dynamic"
# }

# # Create network interface
# resource "azurerm_network_interface" "my_nic" {
#   name                = "my_nic_n"
#   location            = var.location
#   resource_group_name = var.resource_group_name

#   ip_configuration {
#     name                          = "my_nic_configuration"
#     subnet_id                     = module.vnet.subnet["subnet_1"].id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.linux_vm_public_ip.id
#   }
# }

# # # Connect the security group to the network interface
# resource "azurerm_network_interface_security_group_association" "connect_nic_ngp_new" {
#   network_interface_id      = azurerm_network_interface.my_nic_new.id
#   network_security_group_id = azurerm_network_security_group.my_ngp.id
# }


# # Create (and display) an SSH key
# resource "tls_private_key" "vm_ssh_new" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "local_file" "vm_ssh_key_file" {
#   filename = "vm_ssh_key_file.pem"
#   content = tls_private_key.vm_ssh.private_key_pem
# }


# # Create virtual machine
# resource "azurerm_linux_virtual_machine" "linux_vm_new" {
#   name                  = "linux_vm_new"
#   location              = var.location
#   resource_group_name   = var.resource_group_name
#   network_interface_ids = [azurerm_network_interface.my_nic_new.id]
#   size                  = "Standard_E2bds_v5"
#   admin_username        = "my_vm_admin"

#   admin_ssh_key {
#     username = "my_vm_admin_new"
#     # public_key = file("~/.ssh/id_rsa.pub")
#     public_key= tls_private_key.vm_ssh.public_key_openssh
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "18.04-LTS"
#     version   = "latest"
#   }
#   os_disk {
#     # name               = "myosdisk1"
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }
 
#     computer_name  = "hostname"
#     # admin_username = "my_vm_admin_new"
 
# }

