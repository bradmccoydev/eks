module "db_password" {
  length           = 10
  special          = true
  override_special = "_%@"
}

locals {
  cluster_details = {
    username = "brad"
    something = "mccoy"
    db_password = ""
  }
}

module "aws_secretsmanager_secret" "default" {
  source = "github.com/bradmccoydev/terraform-modules//aws/aws_secretsmanager_secret"
  name   = "${var.secret_name}-${random_string.random.result}"
  tags   = merge(local.tags, var.cloud_custom_tags)
}

module "aws_secretsmanager_secret_version" "default" {
  source        = "github.com/bradmccoydev/terraform-modules//aws/aws_secretsmanager_secret_version"
  secret_id     = aws_secretsmanager_secret.default.id
  secret_string = jsonencode(local.cluster_details)
}
