######################### API Gateway #################################
resource "aws_apigatewayv2_api" "lambda_for_serverless_backend_api" {
  name          = var.api_name
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = var.allow_origins
    allow_headers = var.allow_headers
    allow_methods = var.allow_methods
  }

  tags = {
    "Name"                    = var.finance_product
    "Role"                    = "${var.backend_role}-${var.name_env}"
    "Environment"             = var.finance_env
  }
}

resource "aws_apigatewayv2_stage" "stage_for_serverless_backend_lambda" {
  api_id = aws_apigatewayv2_api.lambda_for_serverless_backend_api.id

  name        = "$default"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}

resource "aws_apigatewayv2_integration" "integration_for_serverless_backend_lambda" {
  api_id           = aws_apigatewayv2_api.lambda_for_serverless_backend_api.id
  integration_type = "AWS_PROXY"

  connection_type           = "INTERNET"
  description               = "Integration for serverless bst-backend lambda"
  integration_method        = "POST"
  integration_uri           = aws_lambda_function.lambda_for_serverless_backend.invoke_arn
  payload_format_version    = "2.0"
}

resource "aws_apigatewayv2_route" "lambda_for_serverless_backend_route" {
  api_id    = aws_apigatewayv2_api.lambda_for_serverless_backend_api.id

  route_key = var.http_route_key
  target    = "integrations/${aws_apigatewayv2_integration.integration_for_serverless_backend_lambda.id}"
}

###################### Lambda Invoke Permission ########################
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_for_serverless_backend.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_apigatewayv2_api.lambda_for_serverless_backend_api.execution_arn}/*/*"
}

############################### Logs ##################################
resource "aws_cloudwatch_log_group" "api_gw" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.lambda_for_serverless_backend_api.name}"

  retention_in_days = 30
}