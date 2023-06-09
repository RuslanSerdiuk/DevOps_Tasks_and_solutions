# Project Infrastructure

The current infrastructure is located in 3 cloud providers - AWS, Azure, GCP

> Do not make any changes to `bst-terraform-statefiles` :bangbang:

## AWS
- [bst-admin](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/Serverless%20Lambda%20-%20Static%20CDN/AWS/bst-admin) - infrastructure for admin frontend.
- [bst-backend](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/Serverless%20Lambda%20-%20Static%20CDN/AWS/bst-backend) - infrastructure for backend.
- [bst-frontend](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/Serverless%20Lambda%20-%20Static%20CDN/AWS/bst-frontend) - infrastructure for frontend.
- [bst-terraform-statefiles](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/Serverless%20Lambda%20-%20Static%20CDN/AWS/bst-terraform-statefiles) - infrastructure for terraform state files.

## AZURE
- [bst-admin](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/Serverless%20Lambda%20-%20Static%20CDN/AZURE/bst-admin) - infrastructure for admin frontend.
- [bst-backend](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/Serverless%20Lambda%20-%20Static%20CDN/AZURE/bst-backend) - infrastructure for backend.
- [bst-frontend](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/Serverless%20Lambda%20-%20Static%20CDN/AZURE/bst-frontend) - infrastructure for frontend.
- [bst-terraform-statefiles](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/Serverless%20Lambda%20-%20Static%20CDN/AZURE/bst-terraform-statefiles) - infrastructure for terraform state files.


## Workflow:
1. clone this repo
2. Go to the directory you need (`bst-admin`, `bst-backend`, `bst-frontend` or `bst-terraform-statefiles`:warning:)
3. Run these commands to make changes to the infrastructure:
    ```
    terraform init
    
    export TF_VAR_aws_access_key_id="your_access_key_id"
    export TF_VAR_aws_secret_access_key="your_secret_access_key"
    export TF_VAR_aws_session_token="your_session_token"
    export TF_VAR_region="eu-central-1"
    
    terraform workspace list
    terraform workspace select dev | prod
    
    terraform plan -var-file="env/dev.tfvars"
    terraform apply -var-file="env/dev.tfvars"
    ```

4. For backend:
    ```
    EXPORT ENV VARIABLES FOR BACKEND LAMBDA:
    
    export TF_VAR_NODE_ENV=""
    export TF_VAR_APP_NAME=""
    export TF_VAR_APP_FALLBACK_LANGUAGE=""
    export TF_VAR_APP_HEADER_LANGUAGE=""
    export TF_VAR_FRONTEND_DOMAIN=""
    export TF_VAR_AUTH_JWT_SECRET=""
    export TF_VAR_AUTH_JWT_TOKEN_EXPIRES_IN=""
    export TF_VAR_CTP_CLIENT_ID=""
    export TF_VAR_CTP_PROJECT_KEY=""
    export TF_VAR_CTP_CLIENT_SECRET=""
    export TF_VAR_CTP_AUTH_URL=""
    export TF_VAR_CTP_API_URL=""
    export TF_VAR_CTP_SCOPES=""
    export TF_VAR_ENCRYPTION_KEY=""
    export TF_VAR_TOKEN_ENCRYPTION_ENABLED=""
    export TF_VAR_GIT_COMMIT=""
    export TF_VAR_GIT_BRANCH=""
    export TF_VAR_GIT_TAGS=""
    ```

#### If state file has been locked: `terraform force-unlock <ID_of_the_statefile>`

## Azure
In progress...

## GCP
In progress...

