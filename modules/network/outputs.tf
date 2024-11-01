# used the output values in different modules easily
output "resource_group" {
  value = azurerm_resource_group.resource_group.name
}
output "location" {
  value = azurerm_resource_group.resource_group.location
}
output "subnet_id" {
  # using for to loop through subnet id and assign the key to subnet id
  value = { for key, subnet in azurerm_subnet.subnet : key => subnet.id }
}

output "environment" {
  value = var.environment
}

output "virtual_network_id" {
  value = azurerm_virtual_network.virtual_network.id
}
