#========================== Secret Manager for Snowflake Credentials ===============================
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

#========================== Secret Manager for Comm Service alert to Slack ===============================

resource "aws_secretsmanager_secret" "comm_service_alerts_to_slack_secrets" {
  name = "${var.name_secret_for_comm_service}-${var.name_env}"
  tags = {
    Name                      = "${var.backend_role}-${var.finance_env}"
    Role                      = "${var.backend_role}-${var.finance_env}"
    "EpicFinance:Environment" = var.finance_env
    "EpicFinance:Owner"       = var.finance_owner
  }
}

resource "aws_secretsmanager_secret_version" "sversion_for_comm_service" {
  secret_id = aws_secretsmanager_secret.comm_service_alerts_to_slack_secrets.id
  secret_string = <<EOF
    {"SLACK_URL":"${var.SLACK_URL}"}
EOF
}
