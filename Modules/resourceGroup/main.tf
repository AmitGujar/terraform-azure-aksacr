resource "azurerm_resource_group" "resource_name" {
  name     = var.resource_name
  location = var.location

  tags = {
    Exp = "5"
  }
}
