# :computer: Examples of Some Useful Solutions :wrench:

### [DOCUMENTATION](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Documentation/Materials/Automation-Tools/Ansible.pdf) :metal:




#### [Simple Application](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/Simple_Application) - an example of how to deploy a simple application to AWS and the infrastructure for it using Terraform
#### [Glue-Job: DynamoDB to Snowflake Migration](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/%5BAWS%5D-GlueJob-DynamoDBtoSnowflakeMigration) - Deploy Glue-Job + trigger for it / S3 Bucket for python script / Deploy secret-manager + lambda / Create several Environments!
#### [Serverless Lambda - Static CDN](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Serverless%Lambda%-%Static%CDN/AWS) - Creating infrastructure for serverless backend and static frontend.



### Local state for AWS:
```
terraform {
  backend "local" {
    path = ".tfstate"
  }
}

provider "aws" {
  region     = var.region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}
```




### Remote state for AWS:
```
terraform {
  backend "s3" {
    bucket = "tf-ruslan-bucketfor-statefiles"
    key = "terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "tf-ruslan-state-locks"
    encrypt = true
  }
}


provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  
  region     = var.region
}

```



### Remote state for AZURE Cloud:
```
terraform {
  backend "azurerm" {
    resource_group_name  = "epmc-mach-resources"
    storage_account_name = "machterraformstatelock"
    container_name       = "terraform-state-files"
    key                  = "terraform-infrastructure/AZURE/dev/bst-backend.tfstate"
  }
}


terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
```


#### Create DynamoDB and S3 for AWS remote state:
```
####################################################################
#        Create a DynamoDB Table for locking the state file        #
####################################################################
resource "aws_dynamodb_table" "terraform_state_locks" {
  name = var.dynamodb_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    name        = var.dynamodb_table
    description = "DynamoDB terraform table to lock states"
  }
}


####################################################################
#        Create an S3 Bucket to store the state file in            #
####################################################################
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.state_bucket
  object_lock_enabled = true
  
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name = var.state_bucket
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "S3_access_block" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
```

