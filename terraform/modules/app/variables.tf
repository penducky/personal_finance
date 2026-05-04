variable "project" {
  description = "Name of the project"
  type        = string
}

variable "env" {
  description = "Environment of the project"
  type        = string
}

variable "vpc" {
  description = "VPC object"
  type        = any
}

variable "public_subnet" {
  description = "Public subnet"
  type        = map(any)
}

variable "private_subnet" {
  description = "Private subnet"
  type        = map(any)
}

variable "sg_alb" {
  description = "Security group for the ALB"
  type        = any
}

variable "sg_ecs" {
  description = "Security group for the ECS"
  type        = any
}

variable "ecr_repo_name" {
  description = "Name of the ECR Repository"
  type        = string
}