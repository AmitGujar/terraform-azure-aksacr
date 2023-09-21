data "azurerm_virtual_network" "data_virtual_network" {
  name                = module.virtual_network.virtual_network
  resource_group_name = module.resource_group.resource_name
  depends_on = [
    module.virtual_network
  ]
}


data "azurerm_subnet" "data_cluster_subnet" {
  name                 = module.virtual_network.cluster_subnet.name
  virtual_network_name = module.virtual_network.virtual_network
  resource_group_name  = module.resource_group.resource_name
  depends_on = [
    module.virtual_network
  ]
}

data "azurerm_subnet" "data_links_subnet" {
  name                 = module.virtual_network.links_subnet.name
  virtual_network_name = module.virtual_network.virtual_network
  resource_group_name  = module.resource_group.resource_name
  depends_on = [
    module.virtual_network
  ]
}

data "azurerm_subnet" "data_jumpbox_subnet" {
  name                 = module.virtual_network.jumpbox_subnet.name
  virtual_network_name = module.virtual_network.virtual_network
  resource_group_name  = module.resource_group.resource_name
  depends_on = [
    module.virtual_network
  ]
}

data "azurerm_public_ip" "data_jumpbox_public_ip" {
  name                = module.virtual_network.jumpbox_public_ip.name
  resource_group_name = module.resource_group.resource_name
  depends_on = [
    module.virtual_network
  ]
}