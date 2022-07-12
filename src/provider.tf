terraform {
  required_version = ">= 0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.14, < 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

provider "random" {
}
