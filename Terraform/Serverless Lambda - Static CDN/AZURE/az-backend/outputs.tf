############################
# Lambda                   #
############################
output "Serverless_Lambda_ID" {
  value = azurerm_windows_function_app.lambda_for_serverless_backend.id
}