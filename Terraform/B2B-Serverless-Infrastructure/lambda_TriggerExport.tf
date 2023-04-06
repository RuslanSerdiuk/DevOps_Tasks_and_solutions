######################### Lambda 2: trigger warming #######################################
resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda_for_warming_data" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.trigger_lambda_warming.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.b2b_project_fift_min_event.arn
}

resource "aws_lambda_function" "trigger_lambda_warming" {
  s3_bucket = "${var.name_bucket}-${var.name_env}"
  s3_key    = var.s3_key_file_for_function_2

  function_name = "${var.function_name}-${var.name_env}"
  role          = var.role_for_lambda
  handler       = var.lambda_handler
  runtime       = "nodejs12.x"
  timeout       = 3

  tags = {
    "Name"                    = "${var.role}-${var.finance_env}"
    "Role"                    = "${var.role}-${var.finance_env}"
    "EpicFinance:Environment" = var.finance_env
  }
}
