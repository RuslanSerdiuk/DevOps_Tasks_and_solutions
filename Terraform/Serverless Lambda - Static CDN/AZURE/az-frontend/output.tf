output "frontend_hostname" {
  value = azurerm_storage_account.storage_account_for_cdn.primary_web_host
}

output "frontend_cdn_hostname" {
  value = azurerm_cdn_endpoint.cdn_endpoint.fqdn
}