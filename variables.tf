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


variable "sql_server_name" {
  description = "The name of the SQL Server."
  type        = string
}

variable "sql_database_name" {
  description = "The name of the SQL Database."
  type        = string
}

variable "sql_server_version" {
  description = "The version of the SQL Server."
  type        = string
  default     = "12.0"
}

variable "administrator_login" {
  description = "The administrator login for the SQL Server."
  type        = string
}

variable "administrator_login_password" {
  description = "The administrator password for the SQL Server."
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
}
