variable "resource_name" {
  type        = string
  default     = "rg-amit-001"
  description = "Name of resource group"
}

variable "location" {
  type        = string
  description = "Location of resource group"
  default     = "centralindia"
}

variable "client_id" {
  description = "Client id of your service principal"
}

variable "client_secret" {
  description = "Client secret of your service principal"
}

variable "principal_id" {
  description = "Principal id of user who wants to access the aks cluster"
}

variable "acr_name" {
  type        = string
  description = "Name of the Azure Container Registry"
}

variable "cluster_name" {
  type        = string
  description = "Name of the AKS cluster"
  default     = "aks-test-001"
}

variable "agent_count" {
  type        = number
  default     = 2
  description = "Number of agent nodes for the AKS cluster"
}

variable "ssh_publickey" {
  type        = string
  description = "SSH public key to use for the cluster"
}
