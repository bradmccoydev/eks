terraform {
  backend "s3" {
    bucket         = "training.bradmccoy.io"
    key            = "eks-devops.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform_locks"
    encrypt        = true
  }
}

locals {
  tags = {
    environment = var.client_environment
    owner       = var.client_id
    repo        = var.client_project_repo
    project     = var.client_project_id
  }

  shared_name    = format("%s-%s",var.client_project_id,var.client_environment)
  primary_name   = "${var.client_project_id}-${var.cloud_location_1.alias}-${var.client_environment}"
}
