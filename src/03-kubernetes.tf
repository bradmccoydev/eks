module "aws_ecr_repository" {
  source = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/aws_ecr_repository?ref=tags/v0.1.1"
  name   = local.shared_name
  tags   = merge(local.tags, var.cloud_custom_tags)
}

module "aws_eks_cluster" {
  source                 = "git::https://github.com/bradmccoydev/terraform-modules//aws/aws_eks_cluster?ref=tags/v0.1.1"
  cluster_name           = local.primary_name
  cluster_role_arn       = module.cluster_aws_iam_role.arn
  endpoint_public_access = true

  subnet_ids = [module.network.private_subnet_1, module.network.private_subnet_2]
}

module "aws_eks_node_group" {
  source               = "git::https://github.com/bradmccoydev/terraform-modules//aws/aws_eks_node_group?ref=tags/v0.1.1"
  cluster_name         = module.aws_eks_cluster.name
  node_group_name      = local.primary_name
  node_role_arn        = module.cluster_node_aws_iam_role.arn
  capacity_type        = var.client_environment == "PROD" ? "ON_DEMAND" : "SPOT"
  kubernetes_node_size = ["t3.medium"]
  disk_size            = var.kubernetes_node_disk_size
  subnet_ids           = [module.network.private_subnet_1, module.network.private_subnet_2]
  scaling_config = {
    desired_size = 2
    max_size     = 4
    min_size     = 1
  }
  tags = merge(local.tags, var.cloud_custom_tags)
}

locals {
  cluster_details = {
    certificate_authority = module.aws_eks_cluster.certificate_authority
  }
}

module "aws_secretsmanager_secret" {
  source        = "git::https://github.com/bradmccoydev/terraform-modules//aws/aws_secretsmanager_secret?ref=tags/v0.1.1"
  secret_name   = local.primary_name
  secret_string = jsonencode(local.cluster_details)
  tags          = merge(local.tags, var.cloud_custom_tags)
}
