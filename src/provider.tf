terraform {
  backend "s3" {
    bucket         = "mentoring-eks-terraform"
    key            = "mentoring-eks.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "terraform_lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

provider "random" {
}
