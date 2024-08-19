provider "aws" {
  region  = var.AWS_REGION
}

terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      version = "~> 4"
    }
    null = {
      version = "~> 3"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "jasuuk-state-file"
    key    = "kubernetes.tfstate"
    region = var.AWS_REGION
    dynamodb_table = "openvpn-terraform-s3"
  }
}
