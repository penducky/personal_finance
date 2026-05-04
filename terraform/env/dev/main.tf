provider "aws" {
  region = "us-east-1"
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

module "app" {
  source         = "../../modules/app"
  project        = var.project
  env            = var.env
  ecr_repo_name  = var.ecr_repository
  vpc            = module.infra.vpc
  public_subnet  = module.infra.public_subnet
  private_subnet = module.infra.private_subnet
  sg_alb         = module.security.sg_alb
  sg_ecs         = module.security.sg_ecs
}


module "security" {
  source  = "../../modules/security"
  project = var.project
  env     = var.env
  vpc     = module.infra.vpc
}