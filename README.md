# AWS_StaticS3_Terraform_Automation
# AWS Static Website with Terraform

This project demonstrates how to deploy a static website using AWS S3 and CloudFront, managed with Terraform. The infrastructure includes an S3 bucket for hosting the website content and a CloudFront distribution for content delivery.

## Project Structure
```
project-root/
├── modules/
│   └── s3-static-website/
│       ├── main.tf # Main module configuration
│       ├── variables.tf # Module variables
│       └── outputs.tf # Module outputs
├── envs/
│   └── dev/
│       ├── main.tf # Development environment configuration
│       ├── variables.tf # Environment variables
│       └── terraform.tfvars # Variable values for development
├── website/
│   ├── index.html # Main website page
│   └── error.html # Error page
├── backend.tf # Backend configuration for state management
├── provider.tf # AWS provider configuration
└── variables.tf # Root variables
```

## Prerequisites

- AWS CLI installed and configured
- Terraform installed (version >= 0.12)
- An AWS account with appropriate permissions

## Setup Instructions

1. **Create Backend Infrastructure**

First, create the S3 bucket and DynamoDB table for Terraform state management:

```bash
# Create S3 bucket for terraform state
aws s3 mb s3://your-terraform-state-bucket

# Create DynamoDB table for state locking
aws dynamodb create-table \
    --table-name terraform-state-lock \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
```
### 2. Update the Backend Configuration
### Edit backend.tf and update the bucket name:
```
terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"  # Update this
    key            = "static-website/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}    
```
### 3. Deploy the Infrastructure
# Navigate to the development environment directory
```
cd envs/dev
```
# Initialize Terraform
```
terraform init
```
# Review the changes
```
terraform plan
```
# Apply the changes
```
terraform apply
```

1. Access your website using the CloudFront URL (https://[cloudfront-domain])
   # Make changes to Terraform files

![Alt text](/image.png)


```
### Cleanup
To destroy the infrastructure:
```
terraform destroy

```
## Important Notes

- The S3 bucket name must be globally unique
- CloudFront distribution can take up to 15 minutes to deploy
- Always review `terraform plan` output before applying changes
- Remember to invalidate CloudFront cache after updating content

## Security Considerations

- The S3 bucket is configured for public read access for website hosting
- HTTPS is enforced through CloudFront
- Terraform state is encrypted in the backend S3 bucket