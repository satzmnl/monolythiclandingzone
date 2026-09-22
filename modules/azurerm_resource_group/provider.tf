terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.4.0"
    }
  }

backend "azurerm" {
    resource_group_name  = "SATTAR_RESOURCE_GROUP"
    storage_account_name = "sattarstorage"
    container_name       = "sattarcontainer"
    key                  = "rg.tfstate"
  }
}

provider "azurerm" {
  features {}
}
