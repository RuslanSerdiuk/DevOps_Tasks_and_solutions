############################
# AWS                      #
############################

aws_role = "arn:aws:iam::154463222472:role/team-epic-push-notifs-tool-contractors"

############################
# Tags                     #
############################

backend_role    = "notification-communication-dynamodb-to-s3-migration"
finance_product = "notification-tool-service"
finance_env     = "prod"
name_env        = "pd"
finance_owner   = "team-epic-push-notifs-tool-contractors"

############################
# S3                       #
############################

name_bucket      = "pns-bucket-for-export-dynamodb"
aws_s3_role_arn  = "arn:aws:iam::154463222472:role/svc-rw-s3-bucket-prefix-pns"

############################
# Glue                     #
############################

job_name            = "CommService_DynamoDB_to_s3"
# name_job_trigger    = "export_commservice_dynamodb_to_s3"
role_arn            = "arn:aws:iam::154463222472:role/svc-rw-s3-bucket-prefix-pns_and_ro_DynamoDB_communications"
script_name         = "/script.py"
