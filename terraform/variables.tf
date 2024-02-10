variable "resource_group_name" {
  type        = string
  nullable    = false
  description = "The name of an existing resource group."
}

variable "location" {
  type        = string
  nullable    = false
  description = "The region where the infrastructure will be built."
  default     = "japanwest"
}

variable "vm_size" {
  type        = string
  nullable    = false
  description = "VM type to choose from https://learn.microsoft.com/ja-jp/azure/virtual-machines/dcv3-series#dcdsv3-series."
  default     = "Standard_DC4ds_v3"
}

variable "node_count" {
  type        = number
  nullable    = false
  description = "The initial quantity of nodes for the node pool."
  default     = 1
}

variable "username" {
  type        = string
  nullable    = false
  description = "The admin username for the new cluster."
  default     = "azureadmin"
}