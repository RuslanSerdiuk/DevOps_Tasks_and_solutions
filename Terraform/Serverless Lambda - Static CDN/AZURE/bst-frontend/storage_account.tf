############################ Storage Account for CDN ##############################
resource "azurerm_storage_account" "storage_account_for_cdn" {
  name                            = "${var.storage_account_name}${var.name_env}"
  resource_group_name             = data.azurerm_resource_group.epmc_mach.name
  location                        = data.azurerm_resource_group.epmc_mach.location
  account_tier                    = var.account_tier
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
  account_kind                    = "StorageV2"
  min_tls_version                 = "TLS1_2"
  enable_https_traffic_only       = true

  static_website {
    index_document = "index.html"
  }
  
  tags = {
    "Name"        = var.finance_product
    "Role"        = "${var.backend_role}-${var.name_env}"
    "Environment" = var.finance_env
  }
}
