# Generate random suffix for globally unique names
resource "random_string" "suffix" {
  length  = 6
  lower   = true
  numeric = true
  special = false
}

# Get current Azure client config
data "azurerm_client_config" "current" {}

# Locals for naming convention
locals {
  name_prefix          = "${var.app_name}-${var.environment}"
  storage_account_name = "${replace(var.app_name, "-", "")}${replace(var.environment, "-", "")}${random_string.suffix.result}"
  key_vault_name       = "${replace(var.app_name, "-", "")}${replace(var.environment, "-", "")}${random_string.suffix.result}"
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "${local.name_prefix}-rg"
  location = var.location

  tags = {
    app_name    = var.app_name
    environment = var.environment
  }
}

# Storage Account
resource "azurerm_storage_account" "main" {
  name                     = local.storage_account_name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    app_name    = var.app_name
    environment = var.environment
  }
}

# Storage Container
resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

# Key Vault
resource "azurerm_key_vault" "main" {
  name                            = local.key_vault_name
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
    app_name    = var.app_name
    environment = var.environment
  }
}
