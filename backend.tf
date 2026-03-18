terraform {
  backend "s3" {
    bucket         = "lcay-iac-lab-tfstate"
    key            = "./backend_support/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    use_lockfile   = true
  }
}