resource "azurerm_virtual_network" "virtual_network" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  resource_group_name = var.resource_name
  location            = var.location
}

# creating subnet
resource "azurerm_subnet" "cluster_subnet" {
  name                 = var.cluster_subnet_name
  resource_group_name  = var.resource_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = var.cluster_subnet_address_prefix
}

resource "azurerm_subnet" "links_subnet" {
  name                 = var.links_subnet_name
  resource_group_name  = var.resource_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = var.links_subnet_address_prefix
}

resource "azurerm_subnet" "jumpbox_subnet" {
  name                 = var.jumpbox_subnet_name
  resource_group_name  = var.resource_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = var.jumpbox_subnet_address_prefix
}

resource "azurerm_public_ip" "jumpbox_public_ip" {
  name                = "pip-jumpbox-centralindia-001"
  resource_group_name = var.resource_name
  location            = var.location
  allocation_method   = "Dynamic"
}
