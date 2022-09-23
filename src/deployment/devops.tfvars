# Client Variables
client_environment   = "devops"
client_project_admin = "bradmccoydev@gmail.com"
client_project_repo  = "https://github.com/bradmccoydev/eks"

# Cloud Variables
cloud_provider                   = "Aws"
cloud_account_id                 = "57b482cf-3355-4f0c-8adb-6d6bbb1b2cf7"
cloud_custom_tags                = { "provisioner" = "terraform", "use" = "eks_demo" }
cloud_transient_instance         = true
cloud_container_registry_enabled = false

cloud_location_1 = {
  name  = "West US"
  alias = "us-west-2"
}

kubernetes_node_size          = "t3.medium"
kubernetes_network_policy     = "calico"
kubernetes_node_disk_size     = 30
kubernetes_initial_node_count = 1
kubernetes_max_node_count     = 3

cloud_location_1_bastion_enabled                   = false
cloud_location_1_network_cidr_range_bastion        = "10.0.0.0/16"
cloud_location_1_subnet_cidr_range_bastion_vm      = "10.0.0.0/24"
cloud_location_1_subnet_cidr_range_bastion_service = "10.0.1.0/24"

cloud_location_1_network_cidr_range   = "10.1.0.0/16"
cloud_location_1_subnet_public_name_1 = "kubernetes"
cloud_location_1_subnet_public_cidr_1 = "10.1.0.0/21"

bastion_ips_to_whitelist = [
  {
    name                = "brad_home_au"
    ip                  = "58.6.235.242/32"
  },
]