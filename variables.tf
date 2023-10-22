variable "resource_name" {
  type        = string
  description = "Name of resource group"
}

variable "location" {
  type        = string
  description = "Location of resource group"
}

variable "client_id" {
  description = "Client id of your service principal"
}

variable "client_secret" {
  description = "Client secret of your service principal"
}

variable "acr_name" {
  type        = string
  description = "Name of the Azure Container Registry"
}