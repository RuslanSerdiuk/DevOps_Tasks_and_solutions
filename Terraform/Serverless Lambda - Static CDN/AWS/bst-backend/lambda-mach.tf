#################################### LAMBDA #######################################
resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda_for_warming_data" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_for_serverless_backend.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.b2b_project_fift_min_event.arn
}

resource "aws_lambda_function" "lambda_for_serverless_backend" {
  s3_bucket = "${var.name_bucket}-${var.name_env}"
  s3_key    = var.s3_key_file

  function_name = "${var.function_name}-${var.name_env}"
  role          = var.role_for_lambda
  handler       = var.lambda_handler
  runtime       = "nodejs18.x"
  timeout       = 6
  memory_size   = 1024

  environment {
    variables = {
      NODE_ENV                  = var.NODE_ENV
      APP_NAME                  = var.APP_NAME
      APP_FALLBACK_LANGUAGE     = var.APP_FALLBACK_LANGUAGE
      APP_HEADER_LANGUAGE       = var.APP_HEADER_LANGUAGE
      FRONTEND_DOMAIN           = var.FRONTEND_DOMAIN
      AUTH_JWT_SECRET           = var.AUTH_JWT_SECRET
      AUTH_JWT_TOKEN_EXPIRES_IN = var.AUTH_JWT_TOKEN_EXPIRES_IN
      CTP_CLIENT_ID             = var.CTP_CLIENT_ID
      CTP_PROJECT_KEY           = var.CTP_PROJECT_KEY
      CTP_CLIENT_SECRET         = var.CTP_CLIENT_SECRET
      CTP_AUTH_URL              = var.CTP_AUTH_URL
      CTP_API_URL               = var.CTP_API_URL
      CTP_SCOPES                = var.CTP_SCOPES
      ENCRYPTION_KEY            = var.ENCRYPTION_KEY
      TOKEN_ENCRYPTION_ENABLED  = var.TOKEN_ENCRYPTION_ENABLED
      GIT_COMMIT                = var.GIT_COMMIT
      GIT_BRANCH                = var.GIT_BRANCH
      GIT_TAGS                  = var.GIT_TAGS
    }
  }

  tags = {
    "Name"                    = var.finance_product
    "Role"                    = "${var.backend_role}-${var.name_env}"
    "Environment"             = var.finance_env
  }
}
