terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  client_id       = "ec344146-68dc-4625-9869-bae7cd165838"
  client_secret   = "ebo8Q~BMVIU_e_VOqiZ3mXWVmNBsTedA6GJAvaO3"
  subscription_id = "0e34cec9-855a-494c-972a-034cbc92b040"
  tenant_id       = "47d4542c-f112-47f4-92c7-a838d8a5e8ef"
}

module "networking" {
  source = "./networking-module"

  # Input variables for the networking module
  resource_group_name = "networking-resource-group"
  location           = "UK South"
  vnet_address_space = ["10.0.0.0/16"]
}