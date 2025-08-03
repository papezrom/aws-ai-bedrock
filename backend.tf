terraform {
  backend "s3" {
    bucket       = "rrobots-terraform-state-bucket-eu-central-1"
    key          = "aws-ai-bedrock/terraform.tfstate"
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true
  }
}