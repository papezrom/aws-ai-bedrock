# Generate a random 5-character string
resource "random_string" "id_suffix" {
  length  = 5
  upper   = false
  lower   = true
  special = false
  numeric = true
}

### S3 Buckets for CMS and Bedrock Logs
module "cms_static_files_bucket" {
  source                    = "./modules/s3"
  bucket_name               = "cms-product-static-files-${random_string.id_suffix.result}"
  versioning                = true
  force_destroy             = false
  lifecycle_enabled         = false
  lifecycle_prefix          = "static-files/"
  lifecycle_expiration_days = 180
  block_public_acls         = true
  block_public_policy       = true
  sse_algorithm             = "AES256"
  tags = {
    Name = "CMS Static Files"
  }
}

### Bedrock Logs Bucket
module "bedrock_logs_bucket" {
  source                    = "./modules/s3"
  bucket_name               = "bedrock-prompts-logs-${random_string.id_suffix.result}"
  versioning                = true
  lifecycle_enabled         = false
  lifecycle_prefix          = "logs/"
  lifecycle_expiration_days = 365
  block_public_acls         = true
  block_public_policy       = true
  sse_algorithm             = "AES256"
  tags = {
    Name = "Bedrock Logs"
  }
}

### Bedrock API Schema
module "bedrock_api_schema_bucket" {
  source                    = "./modules/s3"
  bucket_name               = "bedrock-api-schema-${random_string.id_suffix.result}"
  versioning                = true
  lifecycle_enabled         = false
  lifecycle_prefix          = ""
  lifecycle_expiration_days = 365
  block_public_acls         = true
  block_public_policy       = true
  sse_algorithm             = "AES256"
  tags = {
    Name = "Bedrock API Schema"
  }
}

### Complience Regulation Rules Bucket
module "complience_regulation_rules_bucket" {
  source                    = "./modules/s3"
  bucket_name               = "complience-regulation-rules-${random_string.id_suffix.result}"
  versioning                = true
  lifecycle_enabled         = false
  lifecycle_prefix          = ""
  lifecycle_expiration_days = 365
  block_public_acls         = true
  block_public_policy       = true
  sse_algorithm             = "AES256"
  tags = {
    Name = "Complience Regulation Rules"
  }
}

### CloudTrail
module "cloud_trail" {
  source = "./modules/cloud_trail"

  cloudtrail_name    = "frankfurt-cloudtrail"
  s3_key_prefix      = "cloudtrail-logs/"
  log_retention_days = 7

  tags = {
    Environment = "prod"
    Owner       = "rrobots-team"
    ManagedBy   = "terraform"
  }

}

### IAM Users and policies
module "iam" {
  source = "./modules/iam"

  cms_static_files_bucket = module.cms_static_files_bucket.bucket_id
}


### Bedrock
# Disclaimer: This module has limited coverage due to the permissions policy that does not allow creating bedrock agent via Terraform.
module "bedrock" {
  source = "./modules/bedrock"

  bedrock_api_schema_bucket = module.bedrock_api_schema_bucket.bucket_id
  cms_static_files_bucket   = module.cms_static_files_bucket.bucket_id
}

### Drupal CMS instance
module "ec2_drupal" {
  source = "./modules/ec2_drupal"

  vpc_id    = "vpc-xxxxxx"
  subnet_id = "subnet-xxxxxx"
  key_name  = "xxxxxx"
}


### Approval Flow
module "approval_flow" {
  source = "./modules/approval_flow"

  bedrock_logs_bucket     = module.bedrock_logs_bucket.bucket_id
  bedrock_logs_bucket_arn = module.bedrock_logs_bucket.bucket_arn
  eip_allocation_id       = module.ec2_drupal.eip_allocation_id
  ec2_private_dns         = module.ec2_drupal.ec2_private_dns
}