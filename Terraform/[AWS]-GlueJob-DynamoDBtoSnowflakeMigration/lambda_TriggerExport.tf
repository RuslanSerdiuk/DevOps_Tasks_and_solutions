######################### Lambda 2: trigger export #######################################
resource "aws_lambda_permission" "allow_cloudwatch_to_call_senremhandler_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.trigger_lambda_export.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.notification_task_trigger_service_min_event.arn
}

resource "aws_lambda_function" "trigger_lambda_export" {
  s3_bucket = "${var.name_bucket}-${var.name_env}"
  s3_key    = var.s3_key_file_for_function_2

  function_name = "${var.function_2_name}-${var.name_env}"
  role          = var.role_for_function_2
  handler       = var.lambda_trigger_export_s3_to_snowflake_handler
  runtime       = "nodejs12.x"
  timeout       = 3

  tags = {
    "Name"                    = "${var.role}-${var.finance_env}"
    "Role"                    = "${var.role}-${var.finance_env}"
    "EpicFinance:Environment" = var.finance_env
    "EpicFinance:Owner"       = var.finance_owner
  }
}

