#################################### LAMBDA #######################################
resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda_for_warming_data" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.serverless_mach.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.b2b_project_fift_min_event.arn
}

resource "aws_lambda_function" "serverless_mach" {
  s3_bucket = "${var.name_bucket}-${var.name_env}"
  s3_key    = var.s3_key_file

  function_name = "${var.function_name}-${var.name_env}"
  role          = var.role_for_lambda
  handler       = var.lambda_handler
  runtime       = "nodejs18.x"
  timeout       = 3

  tags = {
    "Name"                    = var.finance_product
    "Role"                    = "${var.backend_role}-${var.name_env}"
    "Environment"             = var.finance_env
  }
}
