output "virtual_network" {
  value = azurerm_virtual_network.virtual_network.name
}

output "cluster_subnet" {
  value = azurerm_subnet.cluster_subnet
}

output "jumpbox_public_ip" {
  value = azurerm_public_ip.jumpbox_public_ip
}

output "links_subnet" {
  value = azurerm_subnet.links_subnet
}

output "jumpbox_subnet" {
  value = azurerm_subnet.jumpbox_subnet
}