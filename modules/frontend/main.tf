resource "azurerm_storage_account" "frontend" {
  name                     = "xofrontend2025" # debe ser único globalmente
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "frontend_container" {
  name                 = "frontend"
  storage_account_name = azurerm_storage_account.frontend.name
  container_access_type = "blob" # acceso público para la app Angular
}
