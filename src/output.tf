output "kube_config" {
  value = format("%s%s", "aws eks --region us-west-2 update-kubeconfig --name ", local.primary_name)
}

output "public_subnet_1" {
  value = module.network.public_subnet_1
}

output "public_subnet_2" {
  value = module.network.public_subnet_2
}

output "private_subnet_1" {
  value = module.network.private_subnet_1
}

output "private_subnet_2" {
  value = module.network.private_subnet_2
}
