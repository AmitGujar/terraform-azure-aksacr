output "storage_account_name" {
  value = azurerm_storage_account.tfstorage.name
}

output "storage_account_key" {
  value = azurerm_storage_account.tfstorage.primary_access_key
  sensitive = true
}

output "share_name" {
  value = azurerm_storage_share.tfshare.name
}