output "resource_group" {
  value = module.resource_group.resource_name
}

output "virtual_network" {
  value = module.virtual_network.virtual_network
}

#! turn on this lines if you are using virtual machine module
# output "tls_private_key" {
#   value     = module.virtual_machine.tls_private_key
#   sensitive = true
# }

# output "public_ip_address" {
#   value = module.virtual_machine.public_ip_address
# }

output "acr_test" {
  value = module.acr_test.acr_test
}

output "aks_test" {
  value = module.aks_test.aks_test
}