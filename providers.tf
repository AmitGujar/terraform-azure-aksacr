terraform {
  required_version = ">= 1.0"

  backend "remote" {
    organization = "amithero3342"
    workspaces {
      name = "terraform-azure-aksacr"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
