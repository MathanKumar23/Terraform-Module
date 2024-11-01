resource "azurerm_lb_rule" "lb_rule" {
  name            = "${var.environment}_lb_rule"
  loadbalancer_id = azurerm_lb.lb.id

  # Use a list for the backend pool.. Even if you have only one backend address pool, you need to provide it in a list format.
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.lb_backend.id] # Reference to the backend pool
  #   frontend_ip_configuration_id   = azurerm_lb.example.frontend_ip_configuration[0].id
  frontend_ip_configuration_name = azurerm_lb.lb.frontend_ip_configuration[0].name # based on frontend ip configuration

  protocol                = "Tcp"
  frontend_port           = 80
  backend_port            = 80
  idle_timeout_in_minutes = 4
  load_distribution       = "Default"

  depends_on = [azurerm_lb_backend_address_pool_address.pool_address]
}
