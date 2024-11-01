resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    name  = "${var.environment}-resource-group"
    env   = var.environment
    owner = local.owner
  }
}

resource "azurerm_virtual_network" "virtual_network" {
  #   using count to create multiple vnets in the variable (list type)
  #   length used to have the no.of vents using count index value
  #   count               = length(var.vnets)
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  address_space       = [var.vnet_address_prefix] # we have to read the count the values usig index
}

