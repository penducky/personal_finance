provider "aws" {
  region  = "us-east-1"
  profile = "prod-account"
  default_tags {
    tags = {
      Project     = var.project
      Terraform   = true
      Environment = var.env
    }
  }
}

module "infra" {
  source          = "../../modules/infra"
  aws_region      = var.aws_region
  project         = var.project
  env             = var.env
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  db_subnets      = var.db_subnets

}

module "database" {
  source  = "../../modules/database"
  project = var.project
  env     = var.env
}
