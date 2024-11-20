# Configuración del grupo de recursos
variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
  default     = "rg-aks-pet-clinic"
}

# Ubicación donde se desplegarán los recursos
variable "location" {
  description = "Ubicación donde se desplegarán los recursos"
  type        = string
  default     = "westus"
}

# Nombre del clúster de AKS
variable "aks_name" {
  description = "Nombre del clúster de AKS"
  type        = string
  default     = "aks-pet-clinic"
}

# Número de nodos en el clúster de AKS
variable "node_count" {
  description = "Número de nodos en el clúster de AKS"
  type        = number
  default     = 2
}

# Tamaño de las máquinas virtuales en el clúster de AKS
variable "vm_size" {
  description = "Tamaño de las máquinas virtuales en el clúster de AKS"
  type        = string
  default     = "standard_b2als_v2"
}

# Prefijo DNS para el clúster de AKS
variable "dns_prefix" {
  description = "Prefijo DNS para el clúster de AKS"
  type        = string
  default     = "akspetdns"
}

# Etiquetas para los recursos
variable "tags" {
  description = "Etiquetas para los recursos"
  type        = map(string)
  default = {
    Environment = "Production"
    Project     = "PetClinic"
  }
}

# Configuración de Helm para Linkerd
variable "linkerd_chart_version" {
  description = "Versión del chart de Linkerd"
  type        = string
  default     = "stable-2.11.1"
}

variable "linkerd_namespace" {
  description = "Namespace donde se instalará Linkerd"
  type        = string
  default     = "linkerd"
}

# Configuración de Helm para KEDA
variable "keda_chart_version" {
  description = "Versión del chart de KEDA"
  type        = string
  default     = "v2.8.0"
}

variable "keda_namespace" {
  description = "Namespace donde se instalará KEDA"
  type        = string
  default     = "keda"
}

# Configuración del ScaledObject de KEDA
variable "scaled_object_min_replicas" {
  description = "Número mínimo de réplicas en el ScaledObject de KEDA"
  type        = number
  default     = 1
}

variable "scaled_object_max_replicas" {
  description = "Número máximo de réplicas en el ScaledObject de KEDA"
  type        = number
  default     = 5
}

variable "scaled_object_cpu_utilization" {
  description = "Umbral de utilización de CPU para el ScaledObject de KEDA"
  type        = string
  default     = "50"
}
