variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "ecommerce"
}

variable "env" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Number of public subnets"
  type        = number
  default     = 2
}

variable "private_subnets" {
  description = "Number of private subnets"
  type        = number
  default     = 2
}

variable "db_subnets" {
  description = "Number of database subnets"
  type        = number
  default     = 2
}

variable "ecr_repository" {
  description = "Name of the ECR Repository"
  type        = string
}

