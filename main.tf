terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
}

resource "aws_vpc" "main" {
  cidr_block       = "192.168.1.0/25"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "iac-lab-lcay"
  }
}

