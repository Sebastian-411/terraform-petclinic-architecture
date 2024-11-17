output "principal_id" {
  value = azurerm_kubernetes_cluster.aks_pet.identity[0].principal_id
  description = "El principal_id de la identidad asignada del clúster de AKS"
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.aks_pet.name
  description = "El nombre del clúster de AKS"
}

output "resource_group_name" {
  value = azurerm_kubernetes_cluster.aks_pet.node_resource_group
  description = "El grupo de recursos del clúster de AKS"
}