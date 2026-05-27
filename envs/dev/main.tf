terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "random" {}

# Generate random suffix for globally unique names 1
resource "random_string" "suffix" {
  length  = 6
  lower   = true
  numeric = true
  special = false
}

locals {
  storage_account_name_unique = "${var.storage_account_name}${random_string.suffix.result}"
  key_vault_name_unique       = "${var.key_vault_name}${random_string.suffix.result}"
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# Storage Account
resource "azurerm_storage_account" "main" {
  name                     = local.storage_account_name_unique
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
  }
}

# Get current Azure client config
data "azurerm_client_config" "current" {}

# Storage Container
resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

# Key Vault
resource "azurerm_key_vault" "main" {
  name                            = local.key_vault_name_unique
  location                        = azurerm_resource_group.main.location
  resource_group_name             = azurerm_resource_group.main.name
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = true
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  sku_name                        = "standard"
  soft_delete_retention_days      = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List",
    ]

    secret_permissions = [
      "Get",
      "List",
    ]
  }

  tags = {
    environment = "dev"
  }
}
