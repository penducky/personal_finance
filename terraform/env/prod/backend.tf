terraform {
  backend "s3" {
    bucket       = "terraform-ecommerce-prod-state-bucket"
    key          = "tf-infra/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
    profile      = "prod-account"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}