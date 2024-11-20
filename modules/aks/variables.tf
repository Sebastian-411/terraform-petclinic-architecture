variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
  default     = "rg-aks-pet-clinic"
}

variable "location" {
  description = "Ubicación donde se desplegarán los recursos"
  type        = string
  default     = "westus"
}

variable "aks_name" {
  description = "Nombre del clúster de AKS"
  type        = string
  default     = "aks-pet-clinic"
}

variable "node_count" {
  description = "Número de nodos en el clúster de AKS"
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "Tamaño de las máquinas virtuales en el clúster de AKS"
  type        = string
  default     = "standard_b2ps_v2"
}

variable "dns_prefix" {
  description = "Prefijo DNS para el clúster de AKS"
  type        = string
  default     = "akspetdns"
}

variable "tags" {
  description = "Etiquetas para los recursos"
  type        = map(string)
  default = {
    Environment = "Production"
    Project     = "PetClinic"
  }
}
