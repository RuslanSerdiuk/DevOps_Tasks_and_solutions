############################
# Tags                     #
############################
backend_role    = "mach-bst-backend"
finance_product = "b2b_project"
finance_env     = "prod"
name_env        = "pd"

############################
# S3                       #
############################
name_bucket      = "mach-bst-backend"
upload_directory = "S3Bucket_files/"

############################
# Lambdas                  #
############################

###### Backend Lambda ######
function_name   = "serverless-mach-bst-backend"
role_for_lambda = "arn:aws:iam::863151058727:role/cdk-hnb659fds-cfn-exec-role-863151058727-eu-central-1"
lambda_handler = "dist/lambda.handler"

s3_key_file   = "serverless-backend/bst-backend.zip"

#### API Trigger Lambda ####
api_call_function_name   = "serverless-mach-bst-api-call"
api_call_lambda_handler  = "LambdaTriggerAPI.lambda_handler"

api_call_s3_key_file     = "serverless-backend/LambdaTriggerAPI.zip"

############################
# API Gateway              #
############################
api_name        = "api-serverless-mach-bst-backend"
http_route_key  = "$default"
########### CORS ###########
allow_origins = ["*"]
allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent", "x-amzn-trace-id"]
allow_methods = ["GET", "POST", "OPTIONS", "PATCH", "PUT", "DELETE", "HEAD"]
