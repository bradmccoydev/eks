module "cluster_aws_iam_role" {
  source = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/aws_iam_role"

  role_name                 = var.iam_role_name
  assume_policy_role_object = var.assume_policy_role

  tags = var.tags
}

module "aws_iam_role_policy_attachment_demo" {
  source = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/aws_iam_role_policy_attachment"

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = module.aws_iam_role_demo.name
}