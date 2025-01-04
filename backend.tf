terraform {
  backend "s3" {
    bucket         = "my_bucket343"  # You'll need to change this
    key            = "static-website/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}