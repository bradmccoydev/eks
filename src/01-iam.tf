module "cluster_aws_iam_role" {
  source = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/aws_iam_role?ref=tags/v0.0.2"

  role_name = format("eks-%s-%s", var.name, var.environment)
  assume_policy_role_object = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })

  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  ]

  tags = merge(local.tags, var.cloud_custom_tags)
}

module "cluster_node_aws_iam_role" {
  source = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/aws_iam_role?ref=tags/v0.0.2"

  role_name = format("eks-%s-%s-node", var.name, var.environment)
  assume_policy_role_object = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })

  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    aws_iam_policy.default_eks.arn
  ]

  tags = merge(local.tags, var.cloud_custom_tags)
}

resource "aws_iam_policy" "default_eks" {
  name        = format("eks-%s-%s", var.name, var.environment)
  description = "EKS ${var.environment} Policy"
  policy      = <<EOF
{
    "Statement": [
        {
          "Action": "ecr:*",
          "Effect": "Allow",
          "Resource": [
              "${module.aws_ecr_repository.arn}"
          ],
          "Sid": "VisualEditor1"
        }
    ],
    "Version": "2012-10-17"
}
EOF
}
