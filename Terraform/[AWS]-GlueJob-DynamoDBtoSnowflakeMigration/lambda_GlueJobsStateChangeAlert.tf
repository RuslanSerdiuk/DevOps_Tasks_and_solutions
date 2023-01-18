########################## MONITORING / ALARM ##############################

# Grant access to SNS topic to invoke a lambda function
resource "aws_lambda_permission" "sns_alarms" {
  statement_id  = "AllowExecutionFromSNSAlarms"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.GlueJobSlackAlarm.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.GlueJobsStateChange-AlertToSlack.arn
}

resource "aws_lambda_function" "GlueJobSlackAlarm" {
    s3_bucket     = "${var.name_bucket}-${var.name_env}"
    s3_key        = var.alarm_function_file

    function_name = "${var.alarm_function_name}-${var.name_env}"
    role          = var.lambda_alarm_role
    handler       = var.alarm_function_handler
    runtime       = "python3.9"
    timeout       = 120

    tags = {
      "Name"                    = "${var.role}-${var.finance_env}"
      "Role"                    = "${var.role}-${var.finance_env}"
      "EpicFinance:Environment" = var.finance_env
      "EpicFinance:Owner"       = var.finance_owner
  }
}
