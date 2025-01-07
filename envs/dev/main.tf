module "static_website" {
  source = "../../modules/s3-static-website"

  bucket_name = "my-static-website-${var.environment}"
  environment = var.environment
  
  tags = {
    Project     = "Static Website"
    Environment = var.environment
  }
}