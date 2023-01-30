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

name_bucket      = "communications-bucket-for-export-dynamodb-test"
upload_directory = "S3Bucket_files/"

############################
# Glue                     #
############################

role_arn            = "arn:aws:iam::384461882996:role/TestRoleForGlueJob"
########## Job: 1 ##########
job_name            = "CommService_DynamoDB_to_s3"
script_name         = "/script.py"
name_job_trigger    = "export_commservice_dynamodb_to_s3"
########## Job: 2 ##########
job_2_name          = "export_communications_settings_prod_to_s3"
job_2_script_name   = "/ExpCommSetProd.py"
name_job_2_trigger  = "export_commservice_dynamodb_to_s3_job_2"
########## Job: 3 ##########
job_3_name          = "export_communications_thirdparty_accountmapping_prod_to_s3"
job_3_script_name   = "/ExpCommThirdpartyProd.py"
name_job_3_trigger  = "export_commservice_dynamodb_to_s3_job_3"

############################
# Secret Manager           #
############################

#============== for Snowflake Credentials ================
name_secret                  = "s3-to-snowflake-credentials-migration-test"
#=========== for Comm Service alert to Slack ===========
name_secret_for_comm_service = "communication-service-alerts-to-slack-secrets"

############################
# Lambdas                  #
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
SLACK_URL                       = "https://hooks.slack.com/services/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"

######## Lambda 2: for trigger export process #####

function_2_name     = "TriggerExpS3toSnowflake"
role_for_function_2 = "arn:aws:iam::384461882996:role/communications-glue-job-lambda-trigger"
lambda_trigger_export_s3_to_snowflake_handler = "main.TriggerExportS3toSnowflake"

s3_key_file_for_function_2 = "email-export-lambda.zip"

######## Lambda 3: for glue-jobs alert to slack #####

lambda_alarm_role      = "arn:aws:iam::384461882996:role/SendGlueJobAlarmsToSlack"
alarm_function_name    = "GlueJobSlackAlarm"
alarm_function_handler = "GlueJobsStateChangeAlarmToSlack.lambda_handler"
alarm_function_file    = "GlueJobsStateChangeAlarmToSlack.zip"


