terraform {
  backend "azurerm" {
    resource_group_name  = "project-resources"
    storage_account_name = "projectterraformstatelock"
    container_name       = "terraform-state-files"
    key                  = "terraform-infrastructure/AZURE/project-frontend/project-frontend.tfstate"
  }
}


terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "epmc_mach" {
  name     = var.rg_name
}
