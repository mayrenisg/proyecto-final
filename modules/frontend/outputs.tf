output "storage_account_id" {
  value = azurerm_storage_account.frontend.id
}

output "frontend_storage_account_name" {
  value = azurerm_storage_account.frontend.name
}

output "frontend_container_name" {
  value = azurerm_storage_container.frontend_container.name
}


output "frontend_primary_web_endpoint" {
  value = azurerm_storage_account.frontend.primary_web_endpoint
}
