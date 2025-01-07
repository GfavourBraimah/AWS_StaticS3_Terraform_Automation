variable "bucket_name" {
  description = "Name of the S3 bucket for static website"
  type        = string
  default = "my-static-website-dev"
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default = "dev"
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
}