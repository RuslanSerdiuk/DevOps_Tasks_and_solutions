# Project Infrastructure

The current infrastructure is located in 3 cloud providers - AWS, AZURE, GCP

> Do not make any changes to `[aws|az|gcp]-terraform-statefiles` :bangbang:

## AWS
- [aws-admin](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/Serverless%20Lambda%20-%20Static%20CDN/AWS/aws-admin) - infrastructure for admin frontend.
- [aws-backend](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/Serverless%20Lambda%20-%20Static%20CDN/AWS/aws-backend) - infrastructure for backend.
- [aws-frontend](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/Serverless%20Lambda%20-%20Static%20CDN/AWS/aws-frontend) - infrastructure for frontend.
- [aws-terraform-statefiles](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/Serverless%20Lambda%20-%20Static%20CDN/AWS/aws-terraform-statefiles) - infrastructure for terraform state files.

### Workflow:
1. clone this repo
2. Go to the directory you need **AWS/**(`aws-admin`, `aws-backend`, `aws-frontend` or `aws-terraform-statefiles`:warning:)
3. Run these commands to make changes to the infrastructure:
   ```
   export TF_VAR_aws_access_key_id="your_access_key_id"
   export TF_VAR_aws_secret_access_key="your_secret_access_key"
   export TF_VAR_aws_session_token="your_session_token"
   export TF_VAR_region="eu-central-1" 
   
   terraform init
    
   terraform workspace list
   terraform workspace select dev | prod | qa | secret | demo
    
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



## AZURE
- [az-admin](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/Serverless%20Lambda%20-%20Static%20CDN/AZURE/az-admin) - infrastructure for admin frontend.
- [az-backend](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/Serverless%20Lambda%20-%20Static%20CDN/AZURE/az-backend) - infrastructure for backend.
- [az-frontend](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/Serverless%20Lambda%20-%20Static%20CDN/AZURE/az-frontend) - infrastructure for frontend.
- [az-terraform-statefiles](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/Serverless%20Lambda%20-%20Static%20CDN/AZURE/az-terraform-statefiles) - infrastructure for terraform state files.


### Workflow:
1. clone this repo
2. Go to the directory you need **AZURE/**(`az-admin`, `az-backend`, `az-frontend` or `az-terraform-statefiles`:warning:)
3. Run these commands to make changes to the infrastructure:
    ```
    terraform init
    
    terraform workspace list
    terraform workspace select dev | prod | qa | secret | demo
    
    terraform plan -var-file="env/dev.tfvars"
    terraform apply -var-file="env/dev.tfvars"
    ```
4. The backend uses the same code as the AWS part.




## GCP
- [gcp-admin](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/Serverless%20Lambda%20-%20Static%20CDN/GCP/gcp-admin) - infrastructure for admin frontend.
- [gcp-backend](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/Serverless%20Lambda%20-%20Static%20CDN/GCP/gcp-backend) - infrastructure for backend.
- [gcp-frontend](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/Serverless%20Lambda%20-%20Static%20CDN/GCP/gcp-frontend) - infrastructure for frontend.
- [gcp-terraform-statefiles](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Terraform/Serverless%20Lambda%20-%20Static%20CDN/GCP/gcp-terraform-statefiles) - infrastructure for terraform state files.

### Workflow:
1. clone this repo
2. Go to the directory you need **GCP/**(`gcp-admin`, `gcp-backend`, `gcp-frontend` or `gcp-terraform-statefiles`:warning:)
3. Place the **gcp-key.json** file in the directory with the terraform code.
4. And run these commands to make changes to the infrastructure:
    ```
    terraform init
    
    terraform workspace list
    terraform workspace select dev | prod | qa | secret | demo
    
    terraform plan -var-file="env/dev.tfvars"
    terraform apply -var-file="env/dev.tfvars"
    ```
5. The backend uses the same code as the AWS part.

