############################
# Tags                     #
############################
backend_role    = "mach-bst-backend"
finance_product = "b2b_project"
finance_env     = "prod"
name_env        = "pd"

rg_name         = "epmc-mach-resources"
rg_location     = "West Europe"

############################
# Lambdas                  #
############################
storage_account_name = "b2bproject"
account_tier         = "Standard"

service_plan_name    = "example-app-service-plan"
os_type              = "Linux"

function_name   = "serverless-mach-bst-backend"
role_for_lambda = "arn:aws:iam::863151058727:role/cdk-hnb659fds-cfn-exec-role-863151058727-eu-central-1"
lambda_handler = "dist/lambda.handler"

s3_key_file   = "prod/lambda-mach.zip"

############################
# API Gateway              #
############################
