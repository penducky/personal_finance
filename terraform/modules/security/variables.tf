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