resource "azurerm_subnet" "subnet" {
  # for each to create multiple subnet(same like count, but also used to assign values dynamically)
  # Used map data type which is key value pair. We can also use list or set
  for_each = var.subnets

  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = [each.value.address_prefixes] # read the value using each keyword
}

