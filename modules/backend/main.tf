resource "azurerm_network_interface" "backend_nic" {
  name                = "backend-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "backend_nsg" {
  name                = "backend-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                        = "allow-http-https-websocket"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_ranges     = ["80", "443", "3000"]
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "backend_nic_nsg" {
  network_interface_id      = azurerm_network_interface.backend_nic.id
  network_security_group_id = azurerm_network_security_group.backend_nsg.id
}

resource "azurerm_linux_virtual_machine" "backend_vm" {
  name                = "backend-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_DC1s_v3"

  admin_username = "adminuser"
  admin_password = var.admin_password

  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.backend_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}


