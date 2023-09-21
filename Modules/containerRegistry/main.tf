resource "azurerm_container_registry" "acr_test" {
  name                = var.acr_name
  resource_group_name = var.resource_name
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = true
}
