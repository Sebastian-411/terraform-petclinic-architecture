variable "sql_server_name" {
  description = "The name of the SQL Server."
  type        = string
}

variable "sql_database_name" {
  description = "The name of the SQL Database."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be deployed."
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
  default     = "sqladmin"
}

variable "administrator_login_password" {
  description = "The administrator password for the SQL Server."
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default = {
    environment = "Production"
  }
}
