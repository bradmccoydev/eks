# Client Variables
client_id                   = "ortelius"
client_name                 = "ortelius"
client_project_id           = "gitops"
client_environment          = "prod"
client_project_admin        = "bradmccoydev@gmail.com"
client_budget_amount        = 0
client_project_repo         = "https://github.com/bradmccoydev/eks"
client_access_groups        = ["9611561b-0599-4b2e-b4e2-a190faa1d388"]
client_project_dependencies = []

# Cloud Variables
cloud_provider                   = "Azure"
cloud_account_id                 = "57b482cf-3355-4f0c-8adb-6d6bbb1b2cf7"
cloud_multi_region               = false
cloud_custom_tags                = {}
cloud_transient_instance         = true
cloud_container_registry_enabled = false

cloud_location_1 = {
  name = "East US"
  alias = "usea"
}

cloud_location_1_bastion_enabled                   = true
cloud_location_1_network_cidr_range_bastion        = "10.0.0.0/16"
cloud_location_1_subnet_cidr_range_bastion_vm      = "10.0.0.0/24"
cloud_location_1_subnet_cidr_range_bastion_service = "10.0.1.0/24"

cloud_location_1_network_cidr_range_kubernetes = "10.1.0.0/16"
cloud_location_1_subnet_public_name_1          = "kubernetes"
cloud_location_1_subnet_public_cidr_1          = "10.1.0.0/21"

kubernetes_node_size          = "Standard_B2ms"
kubernetes_network_policy     = "azure"
kubernetes_node_disk_size     = 30
kubernetes_initial_node_count = 1
kubernetes_max_node_count     = 5


####
#VPC & SUBNETS
vpc_cidr_block = "192.168.0.0/16"

subnets = [
  {
    type              = "public-1"
    cidr_block        = "192.168.0.0/18",
    availability_zone = "ap-southeast-2a"
  },
  {
    type              = "public-2"
    cidr_block        = "192.168.64.0/18",
    availability_zone = "ap-southeast-2b"
  },
  {
    type              = "private-1"
    cidr_block        = "192.168.128.0/18",
    availability_zone = "ap-southeast-2a"
  },
  {
    type              = "private-2"
    cidr_block        = "192.168.192.0/18",
    availability_zone = "ap-southeast-2b"
  }
]

#IAM
iam_role_name = "eks_demo_iam_role"

assume_policy_role = {
  Version = "2012-10-17",
  Statement = [
    {
      Effect = "Allow",
      Action = "sts:AssumeRole",
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }
  ]
}

#SECURITY GROUP
sg_name        = "sg_eks_cluster_demo"
sg_description = "EKS Cluster demo ingress security group."

#CLUSTER
cluster_name = "eks_demo_cluster"

#SHARED TAGS
tags = { "provisioner" = "terraform", "use" = "eks_demo" }