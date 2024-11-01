
# creating backend address pool for distribute traffic
resource "azurerm_lb_backend_address_pool" "lb_backend" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "${var.environment}-backend-pool"

  depends_on = [azurerm_lb.lb]
}

# creating address pool to distribute tarffic to the vms using nic private address
resource "azurerm_lb_backend_address_pool_address" "pool_address" {
  count                   = length(var.nic) # count based on nic available
  name                    = "${var.environment}-pool-address-${count.index + 1}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend.id
  ip_address              = element(var.nic, count.index) # based on nic address which has attached to specific vms
  virtual_network_id      = var.virtual_network_id
}
