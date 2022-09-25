module "cluster_aws_iam_role" {
  source = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/aws_iam_role?ref=tags/v0.1.1"

  role_name = format("eks-%s", local.shared_name)
  assume_policy_role_object = {
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  }

  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  ]

  tags = merge(local.tags, var.cloud_custom_tags)
}

module "cluster_node_aws_iam_role" {
  source = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/aws_iam_role?ref=tags/v0.1.1"

  role_name = format("eks-%s-node", local.shared_name)
  assume_policy_role_object = {
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  }

  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]

  tags = merge(local.tags, var.cloud_custom_tags)
}

resource "aws_iam_policy" "default_eks" {
  name        = local.primary_name
  description = "EKS ${var.client_environment} Policy"
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
        },
        {
          "Effect": "Allow",
          "Action": [
            "route53:ChangeResourceRecordSets"
          ],
          "Resource": [
            "arn:aws:route53:::hostedzone/*"
          ]
        },
        {
          "Effect": "Allow",
          "Action": [
            "route53:ListHostedZones",
            "route53:ListResourceRecordSets"
          ],
          "Resource": [
            "*"
          ]
        }
    ],
    "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_role_policy_attachment" "defaul" {
  role       = module.cluster_node_aws_iam_role.name
  policy_arn = aws_iam_policy.default_eks.arn
}
