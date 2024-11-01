output "public_nic" {
  value = azurerm_network_interface.public_nic[*].private_ip_address
}

output "private_nic" {
  value = azurerm_network_interface.private_nic[*].private_ip_address
}
