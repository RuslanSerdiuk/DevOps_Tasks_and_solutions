############################
# Tags                     #
############################

backend_role = "notification-coomunication-dynamodb-to-s3-migration"
finance_product = "notification-tool-service"
finance_env = "prod"
name_env = "pd"
finance_owner = "team-epic-push-notifs-tool-contractors"

############################
# S3                       #
############################

name_bucket      = "pns-bucket-for-export-dynamodb"
upload_directory = "S3Bucket_files/"

############################
# Glue                     #
############################

job_name            = "CommService_DynamoDB_to_s3"
name_job_trigger    = "export_commservice_dynamodb_to_s3"
role_arn            = "arn:aws:iam::384461882996:role/TestRoleForGlueJob"
script_name         = "/script.py"

############################
# Secret Manager           #
############################

name_secret            = "Snowflake_credentials"
