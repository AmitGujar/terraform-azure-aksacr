variable "resource_name" {
  type = string
}

variable "location" {
  type = string
}

variable "agent_count" {
  type = number
}

variable "cluster_name" {
  type = string
}

variable "dns_prefix" {
  default = "dns-aks-clmigration-001"
}

variable "aks_subnet_id" {
  description = "The ID of the subnet where the AKS cluster will be deployed."
}

variable "ssh_publickey" {
  description = "The SSH public key to use for the cluster."
  type        = string
}

variable "client_id" {
  description = "client id for aks"
}

variable "client_secret" {
  description = "value of client secret for aks"
}

variable "principal_id" {
  description = "principle id of user"
}

variable "role_definition_name" {
  description = "role definition name"
  default     = "Azure Kubernetes Service RBAC Cluster Admin"
}
