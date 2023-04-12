resource "aws_dynamodb_table" "terraform_state_locks" {
  name = "tf-ruslan-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    name        = "tf-ruslan-state-locks"
    description = "DynamoDB terraform table to lock states"
  }
}