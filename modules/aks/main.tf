provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.aks_pet.kube_config[0].host
  cluster_ca_certificate = azurerm_kubernetes_cluster.aks_pet.kube_config[0].cluster_ca_certificate
  client_key             = azurerm_kubernetes_cluster.aks_pet.kube_config[0].client_key
  client_certificate     = azurerm_kubernetes_cluster.aks_pet.kube_config[0].client_certificate
}

provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.aks_pet.kube_config[0].host
    cluster_ca_certificate = azurerm_kubernetes_cluster.aks_pet.kube_config[0].cluster_ca_certificate
    client_key             = azurerm_kubernetes_cluster.aks_pet.kube_config[0].client_key
    client_certificate     = azurerm_kubernetes_cluster.aks_pet.kube_config[0].client_certificate
  }
}

resource "azurerm_kubernetes_cluster" "aks_pet" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "petnodepool"
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "helm_release" "linkerd" {
  name       = "linkerd"
  repository = "https://helm.linkerd.io/stable"
  chart      = "linkerd2"
  namespace  = "linkerd"
  create_namespace = true

  values = [
    file("${path.module}/values/linkerd-values.yaml")  # Si tienes un archivo de configuración específico para Linkerd
  ]
}

# Instalación de KEDA usando Helm
resource "helm_release" "keda" {
  name       = "keda"
  repository = "https://kedacore.github.io/charts"
  chart      = "keda"
  namespace  = "keda"
  create_namespace = true
}

resource "kubernetes_manifest" "app_scaled_object" {
  manifest = {
    apiVersion = "keda.sh/v1alpha1"
    kind       = "ScaledObject"
    metadata = {
      name      = "my-app-scaler"
      namespace = "default"
    }
    spec = {
      scaleTargetRef = {
        apiVersion = "apps/v1"
        kind       = "Deployment"
        name       = "my-app"
      }
      minReplicaCount = 1
      maxReplicaCount = 5
      triggers = [
        {
          type = "cpu"
          metadata = {
            type  = "Utilization"
            value = "50"
          }
        }
      ]
    }
  }
}
