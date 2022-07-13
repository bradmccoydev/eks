module "aws_ecr_repository" {
  source = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/aws_ecr_repository?ref=tags/v0.0.3"
  name   = format("%s-%s", var.name, var.environment)
  tags   = var.tags
}
