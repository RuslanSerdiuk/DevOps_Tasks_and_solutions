#========================== Secret Manager =====================================================

resource "aws_secretsmanager_secret" "Snowflake_credentials" {
  name = var.name_secret
  tags = {
    Name                      = "${var.backend_role}-${var.finance_env}"
    Role                      = "${var.backend_role}-${var.finance_env}"
    "EpicFinance:Environment" = var.finance_env
    "EpicFinance:Owner"       = var.finance_owner
  }
}

resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id = aws_secretsmanager_secret.Snowflake_credentials.id
  secret_string = <<EOF
    {"SNOWFLAKE_NOTIFICATIONS_ACCOUNT":"mes.us-east-1","SNOWFLAKE_NOTIFICATIONS_DB":"adminaccount","SNOWFLAKE_NOTIFICATIONS_USER":"TF-Test-USER","SNOWFLAKE_NOTIFICATIONS_PASSWORD":"ADCniqedbin71cqe","SNOWFLAKE_NOTIFICATIONS_SCHEMA":"PUBLIC","SNOWFLAKE_NOTIFICATIONS_WAREHOUSE":"DEVTEST_WH"}
EOF
}