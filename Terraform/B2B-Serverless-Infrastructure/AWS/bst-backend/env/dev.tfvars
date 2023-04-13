############################
# Tags                     #
############################
backend_role    = "mach-bst-backend"
finance_product = "b2b_project"
finance_env     = "dev"
name_env        = "dv"

############################
# S3                       #
############################
name_bucket      = "mach-bst-backend"
upload_directory = "S3Bucket_files/"

############################
# Lambdas                  #
############################
function_name   = "serverless-mach-bst-backend"
role_for_lambda = "arn:aws:iam::384461882996:role/test-role-for-s3-glitter"
lambda_handler = "dist/lambda.handler"

s3_key_file   = "lambda-mach.zip"

############################
# API Gateway              #
############################
api_name        = "api-serverless-mach-bst-backend"
http_route_key  = "$default"
########### CORS ###########
allow_origins = ["*"]
allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent", "x-amzn-trace-id"]
allow_methods = ["GET", "POST", "OPTIONS", "PATCH", "PUT", "DELETE", "HEAD"]
