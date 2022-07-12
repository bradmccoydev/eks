output "kube_config" {
  value = format("%s%s%s%s", "aws eks --region us-west-2 update-kubeconfig --name ", local.primary_name)
}
