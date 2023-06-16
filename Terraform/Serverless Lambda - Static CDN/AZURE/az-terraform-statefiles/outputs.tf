############################
# Resource Group           #
############################
output "Resource_Group_ID" {
  value = azurerm_resource_group.epmc_mach.id
}

############################
# Storage                  #
############################

output "Storage_Account_ID" {
  value = azurerm_storage_account.storage_account_for_epmc_mach.id
}

output "Storage_Container_ID" {
  value = azurerm_storage_container.container_for_tfstatelock.id
}
