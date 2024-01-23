terraform {
  required_version = ">= 1.0"
  # backend "remote" {
  #   # The name of your Terraform Cloud organization.
  #   organization = "amithero3342"

  #   # The name of the Terraform Cloud workspace to store Terraform state files in.
  #   workspaces {
  #     name = "test"
  #   }
  # }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
