locals {
  cluster_details = {
    username    = "brad"
    something   = "mccoy"
  }
}

module "aws_secretsmanager_secret" "default" {
  source = "github.com/bradmccoydev/terraform-modules//aws/aws_secretsmanager_secret?ref=tags/v0.0.4"
  name   = var.secret_name
  tags   = merge(local.tags, var.cloud_custom_tags)
}

module "aws_secretsmanager_secret_version" "default" {
  source        = "github.com/bradmccoydev/terraform-modules//aws/aws_secretsmanager_secret_version?ref=tags/v0.0.4"
  secret_id     = aws_secretsmanager_secret.default.id
  secret_string = jsonencode(local.cluster_details)
}
