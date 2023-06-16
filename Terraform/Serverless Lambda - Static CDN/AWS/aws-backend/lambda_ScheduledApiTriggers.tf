########################## SCHEDULED API TRIGGERS ##############################
# Grant access to CloudWatch Event rule to invoke a lambda function
resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda_for_trigger_api" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_for_api_call.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.b2b_project_twelve_hours_event.arn
}

resource "aws_lambda_function" "lambda_for_api_call" {
    s3_bucket     = "${var.backend_role}-${var.name_env}"
    s3_key        = var.api_call_s3_key_file

    function_name = "${var.backend_role}-api-call-${var.name_env}"
    role          = var.role_for_lambda
    handler       = var.api_call_lambda_handler
    runtime       = "python3.8"
    timeout       = 60

    tags = {
        "Name"                    = var.finance_product
        "Role"                    = "${var.backend_role}-${var.name_env}"
        "Environment"             = var.finance_env
    }
}