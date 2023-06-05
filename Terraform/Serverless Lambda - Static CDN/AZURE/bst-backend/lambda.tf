#################################### LAMBDA #######################################
resource "azurerm_service_plan" "service_plan_for_serverless_backend" {
  name                = "${var.service_plan_name}-${var.name_env}"
  resource_group_name = data.azurerm_resource_group.epmc_mach.name
  location            = data.azurerm_resource_group.epmc_mach.location
  os_type             = var.os_type
  sku_name            = "Y1"


  tags = {
    "Name"        = var.finance_product
    "Role"        = "${var.backend_role}-${var.name_env}"
    "Environment" = var.finance_env
  }
}

resource "azurerm_application_insights" "application_insights_for_serverless_backend" {
  name                = "${var.application_insights_name}-${var.name_env}"
  location            = data.azurerm_resource_group.epmc_mach.location
  resource_group_name = data.azurerm_resource_group.epmc_mach.name
  application_type    = "Node.JS"
}

resource "azurerm_linux_function_app" "lambda_for_serverless_backend" {
  name                = "${var.function_name}-${var.name_env}"
  resource_group_name = data.azurerm_resource_group.epmc_mach.name
  location            = data.azurerm_resource_group.epmc_mach.location

  storage_account_name        = azurerm_storage_account.storage_account_for_serverless_backend.name
  storage_account_access_key  = azurerm_storage_account.storage_account_for_serverless_backend.primary_access_key
  service_plan_id             = azurerm_service_plan.service_plan_for_serverless_backend.id
  functions_extension_version = "~4"

  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE     = var.storage_with_package
    NODE_ENV                     = var.NODE_ENV
    APP_NAME                     = var.APP_NAME
    APP_FALLBACK_LANGUAGE        = var.APP_FALLBACK_LANGUAGE
    APP_HEADER_LANGUAGE          = var.APP_HEADER_LANGUAGE
    FRONTEND_DOMAIN              = var.FRONTEND_DOMAIN
    AUTH_JWT_SECRET              = var.AUTH_JWT_SECRET
    AUTH_JWT_TOKEN_EXPIRES_IN    = var.AUTH_JWT_TOKEN_EXPIRES_IN
    CTP_CLIENT_ID                = var.CTP_CLIENT_ID
    CTP_PROJECT_KEY              = var.CTP_PROJECT_KEY
    CTP_CLIENT_SECRET            = var.CTP_CLIENT_SECRET
    CTP_AUTH_URL                 = var.CTP_AUTH_URL
    CTP_API_URL                  = var.CTP_API_URL
    CTP_SCOPES                   = var.CTP_SCOPES
    ENCRYPTION_KEY               = var.ENCRYPTION_KEY
    TOKEN_ENCRYPTION_ENABLED     = var.TOKEN_ENCRYPTION_ENABLED
    GIT_COMMIT                   = var.GIT_COMMIT
    GIT_BRANCH                   = var.GIT_BRANCH
    GIT_TAGS                     = var.GIT_TAGS
  }

  # zip_deploy_file = "S3Bucket_files/prod/lambda-mach.zip"

  site_config {
    application_stack {
      node_version = 16
    }
    application_insights_connection_string = azurerm_application_insights.application_insights_for_serverless_backend.connection_string
    application_insights_key               = azurerm_application_insights.application_insights_for_serverless_backend.instrumentation_key
  }

  tags = {
    "Name"        = var.finance_product
    "Role"        = "${var.backend_role}-${var.name_env}"
    "Environment" = var.finance_env
  }
}
