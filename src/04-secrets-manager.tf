locals {
  cluster_details = {
    certificate_authority = module.aws_eks_cluster.certificate_authority
  }
}

module "aws_secretsmanager_secret" {
  source        = "git::https://github.com/bradmccoydev/terraform-modules//aws/aws_secretsmanager_secret?ref=tags/v0.0.9"
  secret_name   = local.primary_name
  secret_string = jsonencode(local.cluster_details)
  tags          = merge(local.tags, var.cloud_custom_tags)
}
