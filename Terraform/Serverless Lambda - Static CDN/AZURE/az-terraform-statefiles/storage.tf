#####################################################################
# Create a Storage Account and Container to store the state file in #
#####################################################################
resource "azurerm_storage_account" "storage_account_for_epmc_mach" {
  name                            = var.storage_account_name
  resource_group_name             = azurerm_resource_group.epmc_mach.name
  location                        = azurerm_resource_group.epmc_mach.location
  account_tier                    = var.account_tier
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false

  tags = {
    "Name"        = var.finance_product
    "Role"        = "${var.backend_role}-${var.name_env}"
    "Environment" = var.finance_env
  }
}

resource "azurerm_storage_container" "container_for_tfstatelock" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.storage_account_for_epmc_mach.name
  container_access_type = "private"
}