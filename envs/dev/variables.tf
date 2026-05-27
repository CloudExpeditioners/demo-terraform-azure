variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "demo-rg"
}

variable "storage_account_name" {
  description = "Name of the storage account (must be globally unique)"
  type        = string
  default     = "demostg"
}

variable "key_vault_name" {
  description = "Name of the Key Vault (must be globally unique)"
  type        = string
  default     = "demokv"
}
