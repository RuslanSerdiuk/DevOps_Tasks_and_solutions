############################
# Tags                     #
############################

backend_role = "task-dynamodb-to-s3-to-snowflake-migration"
finance_product = "notification-tool-service"
finance_env = "prod"
name_env = "pd"

############################
# S3                       #
############################

name_bucket      = "communications-bucket-for-export-dynamodb-test"
upload_directory = "S3Bucket_files/"

############################
# Lambdas                  #
############################

function_name   = "ExpS3toSnowflake"
role_for_lambda = "arn:aws:iam::384461882996:role/test-role-for-s3-glitter"
lambda_handler = "main.ExportS3toSnowflake"

s3_key_file   = "lambda.zip"
# vpc_id      = "vpc-a09317cf"
# security_groups = [ "sg-2841954d", "sg-eeeb6e81", "sg-0556d26a" ]
