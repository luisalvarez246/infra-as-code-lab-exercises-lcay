variable "prefix" {
  type        = string
  default     = "lcay-iac-lab"
  description = "Short, unique lowercase prefix for resource names."
}

variable "region" {
  type        = string
  description = "Region to deploy the solution"
  default     = "eu-central-1"
}

variable "TFC_AWS_PROVIDER_AUTH" {
  description = "Terraform auth provider"
  type = bool
}

variable "TFC_AWS_RUN_ROLE_ARN" {
  description = "Terraform run arn"
  type = string
}