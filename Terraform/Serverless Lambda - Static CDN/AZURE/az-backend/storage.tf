#################################### STORAGE #######################################
resource "azurerm_storage_account" "storage_account_for_serverless_backend" {
  name                            = "${var.storage_account_name}${var.name_env}"
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
