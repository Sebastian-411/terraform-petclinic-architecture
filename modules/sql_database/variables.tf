variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "location" {
  description = "Ubicación para desplegar los recursos"
  type        = string
}

variable "sql_admin_password" {
  description = "Contraseña del administrador del SQL Server"
  type        = string
}

variable "sql_server_name" {
  description = "Nombre del servidor SQL"
  type        = string
}

variable "sql_database_name" {
  description = "Nombre de la base de datos SQL"
  type        = string
}
