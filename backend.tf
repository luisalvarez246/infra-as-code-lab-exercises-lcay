terraform {
  backend "s3" {
    bucket         = "lcay-iac-lab-tfstate"
    key            = "./backend_support/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "lcay-iac-lab-tfstate-locks"
    encrypt        = true
  }
}