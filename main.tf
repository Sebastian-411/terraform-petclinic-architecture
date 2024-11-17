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

module "key_vault" {
  source              = "./modules/key_vault"
  resource_group_name = var.resource_group_name
  location            = var.location
  tenant_id           = var.tenant_id
  object_id           = var.object_id
}



module "sql_database" {
  source                 = "./modules/sql_database"
  sql_server_name        = "my-sql-server"
  sql_database_name      = "my-database"
  resource_group_name    = azurerm_resource_group.resource_group_pet_clinic.name
  location               = "eastus"
  sql_server_version     = "12.0"
  administrator_login    = "myadmin"
  administrator_login_password = "securepassword123!"
  tags = {
    environment = "Development"
  }
}
