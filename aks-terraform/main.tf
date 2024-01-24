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
  client_id = data.azurerm_key_vault_secret.client_id.value
  client_secret = data.azurerm_key_vault_secret.client_secret.value
  subscription_id = data.azurerm_key_vault_secret.sub_id.value
  tenant_id = data.azurerm_key_vault_secret.tenant_id.value
}

data "azurerm_key_vault" "existing" {
  name                = "DevOpsKeyStore"
  resource_group_name = "networking-resource-group"
}

data "azurerm_key_vault_secret" "client_id" {
  name         = "Client-ID"
  key_vault_id = data.azurerm_key_vault.existing.id
}

data "azurerm_key_vault_secret" "client_secret" {
  name         = "Client-Secret"
  key_vault_id = data.azurerm_key_vault.existing.id
}

data "azurerm_key_vault_secret" "sub_id" {
  name         = "Sub-ID"
  key_vault_id = data.azurerm_key_vault.existing.id
}

data "azurerm_key_vault_secret" "tenant_id" {
  name         = "Tenant-ID"
  key_vault_id = data.azurerm_key_vault.existing.id
}

module "networking" {
  source = "./networking-module"

  # Input variables for the networking module
  resource_group_name = "networking-resource-group"
  location           = "UK South"
  vnet_address_space = ["10.0.0.0/16"]
}

module "aks_cluster" {
  source = "./aks-cluster-module"

  # Input variables for the AKS cluster module
  aks_cluster_name           = "terraform-aks-cluster"
  cluster_location           = "UK South"
  dns_prefix                 = "aarons-project"
  kubernetes_version         = "1.26.6"  
  service_principal_client_id = "ec344146-68dc-4625-9869-bae7cd165838"
  service_principal_client_secret = "ebo8Q~BMVIU_e_VOqiZ3mXWVmNBsTedA6GJAvaO3"

  # Input variables referencing outputs from the networking module
  resource_group_name         = module.networking.networking_resource_group_name
  vnet_id                     = module.networking.vnet_id
  control_plane_subnet_id     = module.networking.control_plane_subnet_id
  worker_node_subnet_id       = module.networking.worker_node_subnet_id
  aks_nsg_id                  = module.networking.aks_nsg_id
}