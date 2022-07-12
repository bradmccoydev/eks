locals {
  cluster_details = {
    certificate_authority = module.aws_eks_cluster.certificate_authority
  }
}

module "aws_secretsmanager_secret" "default" {
  source = "github.com/bradmccoydev/terraform-modules//aws/aws_secretsmanager_secret?ref=tags/v0.0.2"
  name   = var.secret_name
  tags   = merge(local.tags, var.cloud_custom_tags)
}

module "aws_secretsmanager_secret_version" "default" {
  source        = "github.com/bradmccoydev/terraform-modules//aws/aws_secretsmanager_secret_version?ref=tags/v0.0.2"
  secret_id     = aws_secretsmanager_secret.default.id
  secret_string = jsonencode(local.cluster_details)
}
