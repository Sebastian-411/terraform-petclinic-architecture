variable "subscription_id" {
  description = "Subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Location for the resources"
  type        = string
}

variable "aks_cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "aks_node_count" {
  description = "Number of nodes in the AKS cluster"
  type        = number
}

variable "sql_admin_password" {
  description = "SQL Admin password"
  type        = string
}

variable "sql_server_name" {
  description = "Name of the SQL server"
  type        = string
}

variable "sql_database_name" {
  description = "Name of the SQL database"
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID for Azure"
  type        = string
}

variable "object_id" {
  description = "Object ID for Key Vault access"
  type        = string
}

variable "client_id" {
  description = "client_id for azure"
  type        = string
}

variable "client_secret" {
  description = "client_secret for azure"
  type        = string
}

