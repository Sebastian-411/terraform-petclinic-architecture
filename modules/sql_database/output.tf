
output "sql_database_id" {
  value       = azurerm_sql_database.sql_database.id
  description = "El ID de la base de datos SQL"
  sensitive   = true
}