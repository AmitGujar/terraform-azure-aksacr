variable "resource_name" {
  default     = "rg-amit-001"
  type        = string
  description = "name of resource group"
}

variable "location" {
  default = "centralindia"
  type    = string
}

variable "client_id" {
  description = "client id for aks"
}

variable "client_secret" {
  description = "client secret for aks"
}