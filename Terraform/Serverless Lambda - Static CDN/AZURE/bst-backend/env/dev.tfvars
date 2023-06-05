############################
# Tags                     #
############################
backend_role    = "mach-bst-backend"
finance_product = "b2b_project"
finance_env     = "dev"
name_env        = "dv"

rg_name         = "epmc-mach-resources"
rg_location     = "West Europe"

############################
# Storage                  #
############################
storage_account_name   = "machbackend"
account_tier           = "Standard"

storage_container_name = "bst-backend"

############################
# Lambdas                  #
############################
service_plan_name         = "serverless-app-service-plan"
application_insights_name = "bst-backend-app-insights"
os_type                   = "Linux"

function_name             = "serverless-mach-bst-backend"
storage_with_package      = "https://machbackend.blob.core.windows.net/bst-backend/myfunctionapp.zip"

