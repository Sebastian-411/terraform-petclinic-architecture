terraform {
  required_version = ">=1.0"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "resource_group_pet_clinic" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    project     = "PetClinic"
  }
}

module "aks" {
  source              = "./modules/aks"
  resource_group_name = azurerm_resource_group.resource_group_pet_clinic.name
  location            = var.location
  aks_name            = var.aks_cluster_name
  node_count          = var.aks_node_count
}

// module "key_vault" {
//   source              = "./modules/key_vault"
//   resource_group_name = var.resource_group_name
//   location            = var.location
//   tenant_id           = var.tenant_id
//   object_id           = var.object_id
// }
// 
// module "sql_database" {
//   source                 = "./modules/sql_database"
//   sql_server_name        = var.sql_server_name
//   sql_database_name      = var.sql_database_name
//   resource_group_name    = azurerm_resource_group.resource_group_pet_clinic.name
//   location               = var.location
//   sql_server_version     = var.sql_server_version
//   administrator_login    = var.administrator_login
//   administrator_login_password = var.administrator_login_password
//   tags = {
//     environment = "Development"
//   }
// }
