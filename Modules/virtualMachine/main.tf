resource "azurerm_network_security_group" "my_terraform_nsg" {
  name                = "nsg-jumpbox-001"
  location            = var.location
  resource_group_name = var.resource_name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create network interface
resource "azurerm_network_interface" "my_terraform_nic" {
  name                = "nic-jumpbox-prod-001"
  location            = var.location
  resource_group_name = var.resource_name

  ip_configuration {
    name                          = "my_nic_configuration"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nsgconnection" {
  network_interface_id      = azurerm_network_interface.my_terraform_nic.id
  network_security_group_id = azurerm_network_security_group.my_terraform_nsg.id

  depends_on = [
    azurerm_network_interface.my_terraform_nic
  ]
}

resource "tls_private_key" "private_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "my_terraform_vm" {
  name                  = "vm-jumpbox-prod-001"
  location              = var.location
  resource_group_name   = var.resource_name
  network_interface_ids = [azurerm_network_interface.my_terraform_nic.id]
  size                  = "Standard_B1s"

  os_disk {
    name                 = "osdisk-jumpbox-prod"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "jumpbox-terraform"
  admin_username                  = "amitgujar"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "amitgujar"
    public_key = tls_private_key.private_ssh.public_key_openssh
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = azurerm_linux_virtual_machine.my_terraform_vm.public_ip_address
      user        = "amitgujar"
      private_key = tls_private_key.private_ssh.private_key_pem
    }
    script = "${path.module}/scripts/install.sh"
  }
  depends_on = [
    azurerm_network_interface_security_group_association.nsgconnection
  ]
}