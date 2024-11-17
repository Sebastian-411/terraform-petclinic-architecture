resource "azurerm_key_vault" "key_vault" {
  name                        = "petskeyvault-12345"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = var.enabled_for_disk_encryption
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled    = var.purge_protection_enabled
  sku_name                    = var.sku_name

  access_policy {
    tenant_id = var.tenant_id
    key_permissions   = ["Get", "List"]
    secret_permissions = ["Get", "List"]
  }
}
