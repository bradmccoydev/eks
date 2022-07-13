module "aws_eks_cluster" {
  source = "git::https://github.com/bradmccoydev/terraform-modules//aws/aws_eks_cluster?ref=tags/v0.0.3"
  name     = format("%s-%s", var.name, var.environment)
  role_arn = module.cluster_aws_iam_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.public_1.id, aws_subnet.public_2.id]
  }
}

module "aws_eks_node_group" {
  source = "git::https://github.com/bradmccoydev/terraform-modules//aws/aws_eks_node_group?ref=tags/v0.0.3"
  cluster_name    = aws_eks_cluster.default.name
  node_group_name = format("%s-%s", var.name, var.environment)
  node_role_arn   = module.cluster_node_aws_iam_role.arn
  capacity_type   = var.environment == "PROD" ? "ON_DEMAND" : "SPOT"
  instance_types  = ["t3.medium"]
  subnet_ids      = [aws_subnet.public_1.id, aws_subnet.public_2.id]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
}
