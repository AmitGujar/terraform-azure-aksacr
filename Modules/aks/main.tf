resource "azurerm_kubernetes_cluster" "aks_test" {
  resource_group_name = var.resource_name
  location            = var.location
  name                = var.cluster_name
  node_resource_group = "${var.resource_name}-node-group"
  dns_prefix          = var.dns_prefix


  default_node_pool {
    name            = "workernode"
    vm_size         = "Standard_D2as_v4"
    node_count      = var.agent_count
    vnet_subnet_id  = var.aks_subnet_id
    os_disk_size_gb = 30
  }

  linux_profile {
    admin_username = "amitgujar"
    ssh_key {
      # key_data = file("~/.ssh/id_rsa.pub")
      key_data = var.ssh_publickey
    }
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
    service_cidr      = "10.1.0.0/16"
    dns_service_ip    = "10.1.0.10"
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }
}
