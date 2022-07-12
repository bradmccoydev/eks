module "aws_eks_cluster" "default" {
  source = "github.com/bradmccoydev/terraform-modules//aws/aws_secretsmanager_secret?ref=tags/v0.0.4"
  name     = format("%s-%s", var.name, var.environment)
  role_arn = module.cluster_aws_iam_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.public_1.id, aws_subnet.public_2.id]
  }
}

resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.default.name
  node_group_name = format("%s-%s", var.name, var.environment)
  node_role_arn   = aws_iam_role.node_group.arn
  capacity_type   = "SPOT"
  instance_types  = ["t3.large"]
  subnet_ids      = [aws_subnet.public_1.id, aws_subnet.public_2.id]

  scaling_config {
    desired_size = 3
    max_size     = 4
    min_size     = 3
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}
