#################################### STORAGE #######################################
resource "azurerm_storage_account" "storage_account_for_serverless_backend" {
  name                            = var.storage_account_name
  resource_group_name             = data.azurerm_resource_group.epmc_mach.name
  location                        = data.azurerm_resource_group.epmc_mach.location
  account_tier                    = var.account_tier
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false

  tags = {
    "Name"        = var.finance_product
    "Role"        = "${var.backend_role}-${var.name_env}"
    "Environment" = var.finance_env
  }
}

resource "azurerm_storage_container" "container_for_serverless_backend" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.storage_account_for_serverless_backend.name
  container_access_type = "private"
}

resource "azurerm_storage_share" "storage_share_for_serverless_backend" {
  name                 = "bst-backend"
  storage_account_name = azurerm_storage_account.storage_account_for_serverless_backend.name
  quota                = 1
}

resource "azurerm_storage_share_directory" "share_directory_for_serverless_backend" {
  name                 = "myfunctionapp"
  share_name           = azurerm_storage_share.storage_share_for_serverless_backend.name
  storage_account_name = azurerm_storage_account.storage_account_for_serverless_backend.name
}

resource "azurerm_storage_blob" "storage_blob_for_serverless_backend" {
  name                   = "myfunctionapp.zip"
  storage_account_name   = azurerm_storage_account.storage_account_for_serverless_backend.name
  storage_container_name = azurerm_storage_container.container_for_serverless_backend.name
  type                   = "Block"
  source                 = "serverless.zip"
}