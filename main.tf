module "resource_group" {
  source        = "./Modules/resourceGroup"
  resource_name = var.resource_name
  location      = var.location
}

module "virtual_network" {
  source        = "./Modules/virtualNetwork"
  resource_name = var.resource_name
  location      = var.location
  depends_on = [
    module.resource_group
  ]
}

module "acr_test" {
  source             = "./Modules/containerRegistry"
  resource_name      = var.resource_name
  location           = var.location
  acr_name           = var.acr_name
  virtual_network_id = data.azurerm_virtual_network.data_virtual_network.id
  subnet_id          = data.azurerm_subnet.data_links_subnet.id
  depends_on = [
    module.resource_group
  ]
}

module "storage_account" {
  source        = "./Modules/storage"
  resource_name = var.resource_name
  location      = var.location
  depends_on = [
    module.resource_group
  ]
}

module "aks_test" {
  source        = "./Modules/aks"
  resource_name = var.resource_name
  location      = var.location
  cluster_name  = var.cluster_name
  agent_count   = var.agent_count
  aks_subnet_id = data.azurerm_subnet.data_cluster_subnet.id
  client_id     = var.client_id
  client_secret = var.client_secret
  depends_on    = [module.acr_test]
  ssh_publickey = var.ssh_publickey
  principal_id  = var.principal_id
}


# module "virtual_machine" {
#   source        = "./Modules/virtualMachine"
#   resource_name = var.resource_name
#   location      = var.location
#   subnet_id     = data.azurerm_subnet.data_jumpbox_subnet.id
#   public_ip_id  = data.azurerm_public_ip.data_jumpbox_public_ip.id
#   depends_on = [
#     module.virtual_network
#   ]
# }
