############################
# Glue                     #
############################

output "Snowflake_credentials_ID" {
  value = aws_secretsmanager_secret.Snowflake_credentials.id
}

############################
# S3                       #
############################
