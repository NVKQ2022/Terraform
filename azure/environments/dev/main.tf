

# terraform{
#     required_providers{
#         azurerm = {
#             source = "hashicorp/azurerm"
#             version = "~>4.8.0"
#         }
#     }
#     backend "azurerm" {
#         resource_group_name  = "remotebackend-rg"                 # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
#         storage_account_name = "remotebackendfortfstate"                                 # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
#         container_name       = "tfstate"                                  # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
#         key                  = "dev.terraform.tfstate"                   # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
#     }
#     required_version = ">= 1.9.0"
# }
# provider "azurerm" {
#     features{}
# }


resource "azurerm_resource_group" "example" {
    name     = "teraform-example-RG"
    location = "Southeast Asia"

  tags = { environment = "dev" }
}




# Create the AKS Cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "test-terraform-aks"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "testterraformaks"
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_A2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
   network_profile {
    network_plugin = "azure" # Options: azure, kubenet
    network_policy = "azure" # Options: calico, none

    # Enable Private Cluster (Optional)
    # private_cluster {
    #   enabled = true
    #   private_dns_zone = "my-private-dns-zone"
    # }
  }
  tags = { environment = "dev" }
}

# Output the AKS Cluster information
output "kubernetes_cluster_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.id
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.aks_cluster.name
}

output "aks_cluster_fqdn" {
  value = azurerm_kubernetes_cluster.aks_cluster.fqdn
}
output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw

  sensitive = true
}
