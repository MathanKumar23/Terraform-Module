
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  resource_group_name = var.resource_group_name
  location            = var.location

  # dynamic block to create and assign multiple nsg rules
  dynamic "security_rule" {
    for_each = var.nsg_rules
    content {
      # reading the list of objects to retrive value
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "Mathan_Nsg_Subnet" {
  for_each = var.subnet_id # loop through this, defined in min infra file

  subnet_id                 = each.value
  network_security_group_id = azurerm_network_security_group.nsg.id
}
