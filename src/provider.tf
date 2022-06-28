terraform {
  backend "s3" {
    bucket         = "mentoring-eks-terraform"
    key            = "mentoring-eks.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform_lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-west-2"
}

provider "random" {
}
