resource "azurerm_kubernetes_cluster" "aks_test" {
  resource_group_name = var.resource_name
  location            = var.location
  name                = var.cluster_name
  node_resource_group = "${var.resource_name}-node-group"
  dns_prefix          = var.dns_prefix


  default_node_pool {
    name                        = "systempool"
    temporary_name_for_rotation = "systempool" # this is a workaround for a known issue in Terraform while doing changes in existing cluster
    # vm_size         = "Standard_D2as_v4"
    vm_size         = "Standard_B2s" # perfect for dev-test environment
    node_count      = var.agent_count
    vnet_subnet_id  = var.aks_subnet_id
    os_disk_size_gb = 50
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

  kubernetes_version = "1.28.3"

  # this configuration enables the Azure AD integration with AKS
  local_account_disabled            = true
  role_based_access_control_enabled = true

  azure_active_directory_role_based_access_control {
    managed = true
    admin_group_object_ids = [
      var.principal_id
    ]
    azure_rbac_enabled = true
  }
}

resource "azurerm_role_assignment" "aks_cluster_admin" {
  scope                = azurerm_kubernetes_cluster.aks_test.id
  role_definition_name = var.role_definition_name
  principal_id         = var.principal_id
}

resource "azurerm_kubernetes_cluster_node_pool" "userpool" {
  name                  = "userpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_test.id
  vm_size               = "Standard_D4s_v5"
  node_count            = "1"
  enable_auto_scaling   = true
  lifecycle {
    ignore_changes = all
  }
  min_count             = "1"
  max_count             = "2"
}

# setting up the resource group level lock to prevent accidental deletion
resource "azurerm_management_lock" "resource-group-level" {
  name       = "do-not-touch"
  scope      = azurerm_kubernetes_cluster.aks_test.node_resource_group_id
  lock_level = "CanNotDelete"
  notes      = "This resource can't be deleted"
  depends_on = [
    azurerm_kubernetes_cluster.aks_test
  ]
}
