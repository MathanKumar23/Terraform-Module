resource "azurerm_network_interface" "public_nic" {
  count               = var.environment == "prod" ? 2 : 1
  name                = "${var.environment}-public-nic-${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "${var.environment}-public_config_name-${count.index + 1}"
    subnet_id                     = var.subnet_id["public-subnet"] # referencing my public subnet craeted using map(object)
    private_ip_address_allocation = "Dynamic"

    public_ip_address_id = azurerm_public_ip.public_ip[count.index].id # reference specific IP using count.index
  }
}

resource "azurerm_network_interface" "private_nic" {
  count               = var.environment == "prod" ? 1 : 2
  name                = "${var.environment}-private-nic-${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "${var.environment}-private_config_name-${count.index + 1}"
    subnet_id                     = var.subnet_id["private-subnet"]
    private_ip_address_allocation = "Dynamic"
  }
}
