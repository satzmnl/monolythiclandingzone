terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.3.0"
    }
  }

backend "azurerm" {
    resource_group_name  = "SATTAR_RESOURCE_GROUP"
    storage_account_name = "sattarstorageaccount"
    container_name       = "dev"
    key                  = "prepod.tfstate"
  }
}

provider "azurerm" {
  features {}
}