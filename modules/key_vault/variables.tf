variable "location" {
  description = "Ubicación para desplegar los recursos"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "tenant_id" {
  description = "ID del tenant de Azure"
  type        = string
}

variable "soft_delete_retention_days" {
  description = "Número de días para retención de eliminación suave"
  type        = number
  default     = 7
}

variable "purge_protection_enabled" {
  description = "Habilitar la protección contra purgas"
  type        = bool
  default     = true
}

variable "sku_name" {
  description = "SKU del Key Vault"
  type        = string
  default     = "standard"
}

variable "enabled_for_disk_encryption" {
  description = "Indica si el Key Vault está habilitado para cifrado de discos"
  type        = bool
  default     = true
}
