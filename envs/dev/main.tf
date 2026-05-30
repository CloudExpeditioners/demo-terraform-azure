locals {
  app_name    = var.app_name
  environment = var.environment
  location    = var.location

  naming_prefix = "${local.app_name}-${local.environment}"

  common_tags = {
    application = local.app_name
    environment = local.environment
    managed_by  = "terraform"
  }
}

data "azurerm_client_config" "current" {}

resource "random_string" "storage_suffix" {
  length  = 6
  lower   = true
  upper   = false
  special = false
  numeric = true
}

resource "azurerm_resource_group" "main" {
  name     = "rg-${local.naming_prefix}"
  location = local.location
  tags     = local.common_tags
}

resource "azurerm_storage_account" "main" {
  name                     = lower(replace("st${local.app_name}${local.environment}${random_string.storage_suffix.result}", "-", ""))
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.common_tags
}

resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

resource "azurerm_key_vault" "main" {
  name                            = "kv-${replace(local.naming_prefix, "-", "")}"
  location                        = azurerm_resource_group.main.location
  resource_group_name             = azurerm_resource_group.main.name
  enabled_for_deployment          = true
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = true
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  sku_name                        = "standard"
  soft_delete_retention_days      = 7
  tags                            = local.common_tags
}

resource "azurerm_key_vault_access_policy" "main" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get",
    "List"
  ]

  secret_permissions = [
    "Get",
    "List"
  ]
}
