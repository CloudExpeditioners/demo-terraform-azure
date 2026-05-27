output "resource_group_name" {
  value       = azurerm_resource_group.main.name
  description = "Name of the resource group"
}

output "storage_account_id" {
  value       = azurerm_storage_account.main.id
  description = "ID of the storage account"
}

output "storage_account_name" {
  value       = azurerm_storage_account.main.name
  description = "Name of the storage account"
}

output "storage_container_name" {
  value       = azurerm_storage_container.data.name
  description = "Name of the storage container"
}

output "key_vault_id" {
  value       = azurerm_key_vault.main.id
  description = "ID of the Key Vault"
}

output "key_vault_uri" {
  value       = azurerm_key_vault.main.vault_uri
  description = "URI of the Key Vault"
}
