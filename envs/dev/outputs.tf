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

output "app_service_plan_id" {
  value       = azurerm_service_plan.main.id
  description = "ID of the App Service Plan"
}

output "web_app_id" {
  value       = azurerm_linux_web_app.main.id
  description = "ID of the Linux Web App"
}

output "web_app_default_hostname" {
  value       = azurerm_linux_web_app.main.default_hostname
  description = "Default hostname of the Web App"
}
