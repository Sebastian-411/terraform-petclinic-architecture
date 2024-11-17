output "sql_server_id" {
  description = "The ID of the SQL Server."
  value       = azurerm_sql_server.sql_server.id
}

output "sql_server_name" {
  description = "The name of the SQL Server."
  value       = azurerm_sql_server.sql_server.name
}

output "sql_database_id" {
  description = "The ID of the SQL Database."
  value       = azurerm_sql_database.sql_database.id
}

output "sql_database_name" {
  description = "The name of the SQL Database."
  value       = azurerm_sql_database.sql_database.name
}