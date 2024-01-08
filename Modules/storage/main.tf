resource "random_integer" "rand" {
  min = 10
  max = 99
}

resource "azurerm_storage_account" "tfstorage" {
  resource_group_name      = var.resource_name
  location                 = var.location
  name                     = "tfstorageisgreat${random_integer.rand.result}"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    "container" = "volume"
  }
}

resource "azurerm_storage_share" "tfshare" {
  name                 = var.share_name
  storage_account_name = azurerm_storage_account.tfstorage.name
  quota                = 50
}
