## S3 Backend Configuration

# terraform {
#   backend "s3" {
#     bucket       = "lcay-iac-lab-tfstate"
#     key          = "./tf_prerequisites/terraform.tfstate"
#     region       = "eu-central-1"
#     encrypt      = true
#     use_lockfile = true
#   }
# }

## Terraform Cloud Backend Configuration
terraform {
  backend "remote" {
    organization = "personalLCAY"

    workspaces {
      name = "lcayWorkspace"
    }
  }
}