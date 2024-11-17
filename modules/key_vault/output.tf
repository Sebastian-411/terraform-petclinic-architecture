output "key_vault_id" {
  description = "El ID del Key Vault creado"
  value       = azurerm_key_vault.key_vault.id
}
