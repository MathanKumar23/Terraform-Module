# Haven't variablied much resource here, if wnt we can varaiblize here as well
resource "azurerm_linux_virtual_machine" "public_vm" {
  count                 = var.environment == "prod" ? 2 : 1
  name                  = "${var.environment}-publicVm-${count.index + 1}"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.public_vm_size
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.public_nic[count.index].id]

# If we want can pass below values also as vaiable
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_ssh_key {
    username   = "azureuser"
    public_key = file(var.public_key_path)
  }
  #   Passing userdata to install any appliaction or tools inside Vm
  # passing data as base64 encoded file
  user_data = filebase64(var.encoded_path)
}

resource "azurerm_linux_virtual_machine" "private_vm" {
  count                 = var.environment == "prod" ? 1 : 2
  name                  = "${var.environment}-privateVm-${count.index + 1}"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.private_vm_size
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.private_nic[count.index].id]

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_ssh_key {
    username   = "azureuser"
    public_key = file(var.public_key_path)
  }
  user_data = filebase64(var.encoded_path)
}
