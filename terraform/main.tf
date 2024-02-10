data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "random_pet" "cute" {}

resource "azurerm_attestation_provider" "attestation" {
  name                = replace("attestation-${random_pet.cute.id}", "-", "")
  resource_group_name = var.resource_group_name
  location            = var.location

  # https://github.com/hashicorp/terraform-provider-azurerm/issues/21998
  lifecycle {
    ignore_changes = [
      open_enclave_policy_base64,
      sgx_enclave_policy_base64,
      tpm_policy_base64,
      sev_snp_policy_base64,
    ]
  }
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "aks-${random_pet.cute.id}"
  resource_group_name = var.resource_group_name
  location            = var.location
  dns_prefix          = "dns-${random_pet.cute.id}"

  identity {
    type = "SystemAssigned"
  }

  confidential_computing {
    sgx_quote_helper_enabled = true
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = var.vm_size
    node_count = var.node_count
  }
  linux_profile {
    admin_username = var.username

    ssh_key {
      key_data = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
    }
  }
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
}

resource "local_sensitive_file" "kube_config" {
  filename = "${path.module}/azurek8s"
  content  = azurerm_kubernetes_cluster.k8s.kube_config_raw
}
