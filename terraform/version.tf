terraform {

  required_version = ">= 1.5"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.12.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.71.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.6.0"
    }
  }
}
