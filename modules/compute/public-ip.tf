resource "azurerm_public_ip" "public_ip" {
  count               = var.environment == "prod" ? 2 : 1
  name                = "${var.environment}-public-ip-${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
}
