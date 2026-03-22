variable "prefix" {
  type        = string
  description = "Short, unique lowercase prefix for resource names."
  default = "lcay-iac-lab"
}

variable "region" {
  type        = string
  description = "AWS region to deploy resources (e.g. us-east-1)."
  default     = "eu-central-1"
}
