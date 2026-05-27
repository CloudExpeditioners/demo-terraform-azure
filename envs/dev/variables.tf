variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus2"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "demo-rg"
}

variable "storage_account_name" {
  description = "Name of the storage account (must be globally unique)"
  type        = string
  default     = "demostg12345"
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
  default     = "demo-app-plan"
}

variable "web_app_name" {
  description = "Name of the Linux Web App (must be globally unique)"
  type        = string
  default     = "demo-app-12345"
}
