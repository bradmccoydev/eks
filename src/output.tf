output "kube_config" {
  value = format("%s%s%s%s", "aws eks --region us-west-2 update-kubeconfig --name ", local.primary_name)
}

/* output "vpc_id" {
  value = module.aws_vpc_demo.id
}
output "subnet_ids" {
  value = [for s in module.aws_subnet_demo : s.id]
}
output "iam_role_arn" {
  value = module.aws_iam_role_demo.arn
}
output "sg_id" {
  value = module.aws_security_group_demo.id
}
output "cluster_arn" {
  value = module.aws_eks_cluster_demo.arn
}
output "cluster_id" {
  value = module.aws_eks_cluster_demo.id
}
output "cluster_endpoint" {
  value = module.aws_eks_cluster_demo.endpoint
} */
