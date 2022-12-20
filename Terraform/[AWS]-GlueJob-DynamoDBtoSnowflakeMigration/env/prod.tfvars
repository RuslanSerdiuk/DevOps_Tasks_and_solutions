############################
# Tags                     #
############################

backend_role = "task-dynamodb-to-s3-to-snowflake-migration"
finance_product = "notification-tool-service"
finance_env = "prod"
name_env = "pd"
finance_owner = "team-epic-push-notifs-tool-contractors"

############################
# S3                       #
############################

name_bucket      = "bucket-for-export-dynamodb-to-snowflake"
upload_directory = "S3Bucket_files/"

############################
# Glue                     #
############################

job_name            = "CommService_DynamoDB_to_s3"
name_job_trigger    = "export_commservice_dynamodb_to_s3"
role_arn            = "arn:aws:iam::384461882996:role/TestRoleForGlueJob"
script_name         = "/script.py"

lambda_alarm_role      = "arn:aws:iam::384461882996:role/SendGlueJobAlarmsToSlack"
alarm_function_name    = "GlueJobSlackAlarm"
alarm_function_handler = "function.lambda_handler"
alarm_function_file    = "function.zip"
############################
# Secret Manager           #
############################
/*
name_secret            = "s3-to-snowflake-credentials-migration"
*/
############################
# Lambda                   #
############################

function_name = "ExpS3toSnowflake"
role          = "arn:aws:iam::384461882996:role/test-role-for-s3-glitter"
lambda_export_s3_to_snowflake_handler = "main.ExportS3toSnowflake"

s3_key_file   = "lambda.zip"
# vpc_id      = "vpc-a09317cf"
# security_groups = [ "sg-2841954d", "sg-eeeb6e81", "sg-0556d26a" ]

SNOWFLAKE_NOTIFICATIONS_DB = "adminaccount"
SNOWFLAKE_NOTIFICATIONS_USER = "TF-Test-USER"
SNOWFLAKE_NOTIFICATIONS_PASSWORD = "ADCniqedbin71cqe"
SNOWFLAKE_NOTIFICATIONS_SCHEMA = "PUBLIC"
SNOWFLAKE_NOTIFICATIONS_WAREHOUSE = "DEVTEST_WH"
SNOWFLAKE_NOTIFICATIONS_ACCOUNT = "mes.us-east-1"
