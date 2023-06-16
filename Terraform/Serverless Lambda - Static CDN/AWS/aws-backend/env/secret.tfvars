############################
# Tags                     #
############################
backend_role    = "project-backend"
finance_product = "name_project"
finance_env     = "secret"
name_env        = "st"

############################
# Lambdas                  #
############################

###### Backend Lambda ######
role_for_lambda = "arn:aws:iam::863151058727:role/cdk-hnb659fds-cfn-exec-role-863151058727-eu-central-1"
lambda_handler = "dist/aws_handler.handler"

s3_key_file   = "serverless-backend/bst-backend.zip"

#### API Trigger Lambda ####
api_call_lambda_handler  = "LambdaTriggerAPI.lambda_handler"

api_call_s3_key_file     = "serverless-backend/LambdaTriggerAPI.zip"

############################
# API Gateway              #
############################
http_route_key  = "$default"
########### CORS ###########
allow_origins = ["*"]
allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent", "x-amzn-trace-id"]
allow_methods = ["GET", "POST", "OPTIONS", "PATCH", "PUT", "DELETE", "HEAD"]
