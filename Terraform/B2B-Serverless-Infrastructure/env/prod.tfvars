############################
# Tags                     #
############################
backend_role = "serverless-mach"
finance_product = "b2b_project"
finance_env = "prod"
name_env = "pd"

accountId = "384461882996"
############################
# S3                       #
############################
name_bucket      = "serverless-mach-bst-backend"
upload_directory = "S3Bucket_files/"

############################
# Lambdas                  #
############################
function_name   = "serverless-mach-dev-main"
role_for_lambda = "arn:aws:iam::384461882996:role/test-role-for-s3-glitter"
lambda_handler = "dist/lambda.handler"

s3_key_file   = "lambda-mach.zip"
# vpc_id      = "vpc-a09317cf"
# security_groups = [ "sg-2841954d", "sg-eeeb6e81", "sg-0556d26a" ]
