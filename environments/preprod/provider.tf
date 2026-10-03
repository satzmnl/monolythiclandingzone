terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.7"
    }
  }

  backend "azurerm" {
    resource_group_name  = "SATTAR-RESOURCE-GROUP"
    storage_account_name = "sattarstorage1"
    container_name       = "sattarcontainer"
    key                  = "preprod.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
