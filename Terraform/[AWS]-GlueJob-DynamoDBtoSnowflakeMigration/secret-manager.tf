#========================== Secret Manager =====================================================

resource "aws_secretsmanager_secret" "Snowflake_credentials" {
  name = "${var.name_secret}-${var.name_env}"
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
    {"SNOWFLAKE_NOTIFICATIONS_ACCOUNT":"${var.SNOWFLAKE_NOTIFICATIONS_ACCOUNT}","SNOWFLAKE_NOTIFICATIONS_DB":"${var.SNOWFLAKE_NOTIFICATIONS_DB}","SNOWFLAKE_NOTIFICATIONS_USER":"${var.SNOWFLAKE_NOTIFICATIONS_USER}","SNOWFLAKE_NOTIFICATIONS_PASSWORD":"${var.SNOWFLAKE_NOTIFICATIONS_PASSWORD}","SNOWFLAKE_NOTIFICATIONS_SCHEMA":"${var.SNOWFLAKE_NOTIFICATIONS_SCHEMA}","SNOWFLAKE_NOTIFICATIONS_WAREHOUSE":"${var.SNOWFLAKE_NOTIFICATIONS_WAREHOUSE}"}
EOF
}
