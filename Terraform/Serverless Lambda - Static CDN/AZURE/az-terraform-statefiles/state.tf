terraform {
  backend "azurerm" {
    resource_group_name  = "project-resources"
    storage_account_name = "projectterraformstatelock"
    container_name       = "terraform-state-files"
    key                  = "terraform-infrastructure/AZURE/statelock/project-infrastructure-azure-statelock.tfstate"
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


resource "azurerm_resource_group" "epmc_mach" {
  name     = var.rg_name
  location = var.rg_location

  tags = {
    "Name"        = var.finance_product
    "Role"        = "${var.backend_role}-${var.name_env}"
    "Environment" = var.finance_env
  }
}