resource "aws_lambda_permission" "allow_s3bucket_to_call_ExpS3toSnowflake_lambda" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.export_from_s3_to_snowflake.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${var.name_bucket}-${var.name_env}"
}

resource "aws_lambda_function" "export_from_s3_to_snowflake" {
  s3_bucket     = "${var.name_bucket}-${var.name_env}"
  s3_key        = var.s3_key_file
  
  function_name = "${var.function_name}-${var.name_env}"
  role          = var.role
  handler       = var.lambda_export_s3_to_snowflake_handler
  runtime       = "nodejs12.x"
  timeout       = 120

  tags = {
    "Name"                    = "${var.role}-${var.finance_env}"
    "Role"                    = "${var.role}-${var.finance_env}"
    "EpicFinance:Environment" = var.finance_env
    "EpicFinance:Owner"       = var.finance_owner
  }
}

#====== Adding S3 bucket as trigger to the lambda and giving the permissions =====
resource "aws_s3_bucket_notification" "aws-lambda-trigger" {
  bucket = "${var.name_bucket}-${var.name_env}"
  lambda_function {
    lambda_function_arn = aws_lambda_function.export_from_s3_to_snowflake.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "exports/"
  }
}