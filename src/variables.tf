variable "client_id" {
  description = "Client ID"
  validation {
    condition     = length(var.client_id) > 1 && length(var.client_id) < 12
    error_message = "Client_id must be > 1 && < 12 characters."
  }
}

variable "client_name" {
  description = "Client Name"
  validation {
    condition     = length(var.client_name) > 3 && length(var.client_name) < 13
    error_message = "Client_name must be > 3 && < 13 characters."
  }
}

variable "client_project_id" {
  description = "Project ID"
}

variable "client_environment" {
  description = "Environment eg dev"
}

variable "client_project_admin" {
  type        = string
  description = "The Client Project Admin"
}
variable "client_budget_amount" {
  description = "Monthly budget amount in AUD."
  type        = number
}

variable "client_project_repo" {
  description = "Project source control repository"
}

variable "client_access_groups" {
  description = "Client Access Groups"
  default     = []
}
variable "client_project_dependencies" {
  description = "Project dependencies"
  type        = list(string)
}

variable "cloud_tenant_id" {
  description = "Tenant ID"
  type        = string
}

variable "cloud_account_id" {
  description = "Subscription ID"
  type        = string
}

variable "cloud_multi_region" {
  description = "Cloud Multi Region Region Required"
  type        = bool
}

variable "cloud_location_1" {
  description = "Cloud Location (region)"
}

variable "cloud_location_2" {
  description = "Cloud Location (region)"
}

variable "cloud_partner_id" {
  description = "Cloud partner id"
  type        = string

  validation {
    condition     = length(split("-", var.cloud_partner_id)[0]) == 8 && length(split("-", var.cloud_partner_id)[1]) == 4 && length(split("-", var.cloud_partner_id)[2]) == 4 && length(split("-", var.cloud_partner_id)[3]) == 4 && length(split("-", var.cloud_partner_id)[4]) == 12
    error_message = "Cloud_partner_id must be in this format: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX (8-4-4-4-12)."
  }
}

variable "cloud_transient_instance" {
  description = "The environment"
}

variable "cloud_custom_tags" {
  type = map(string)
}

variable "cloud_provider" {
  type        = string
  description = "The Cloud Provider [ AWS, Azure, GCP ]"
}

variable "cloud_container_registry_enabled" {
  description = "Container Registry Enabled"
}

# Cloud Location 1
variable "cloud_location_1_bastion_enabled" {
  description = "Cloud Bastion Enabled"
}
variable "cloud_location_1_network_cidr_range_bastion" {
  type        = string
  description = "Cloud Network CIDR Range"
}

variable "cloud_location_1_subnet_cidr_range_bastion_vm" {
  type        = string
  description = "Cloud Subnet Cidr Range Bastion VM"
}

variable "cloud_location_1_subnet_cidr_range_bastion_service" {
  type        = string
  description = "Cloud Subnet Cidr Range Bastion Service"
}

variable "cloud_location_1_network_cidr_range_kubernetes" {
  type        = string
  description = "Cloud Network CIDR Range"
}

variable "cloud_location_1_subnet_public_name_1" {
  type        = string
  description = "Cloud Location"
}

variable "cloud_location_1_subnet_public_cidr_1" {
  type        = string
  description = "Cloud Location"
}

# Kubernetes

variable "kubernetes_node_size" {
  type        = string
  description = "Cloud Location"
}

variable "kubernetes_network_policy" {
  type        = string
  description = "Cloud Location"
}

variable "kubernetes_node_disk_size" {
  type        = string
  description = "Cloud Location"
}

variable "kubernetes_initial_node_count" {
  type        = string
  description = "Cloud Location"
}

variable "kubernetes_max_node_count" {
  type        = string
  description = "Cloud Location"
}

/* 
variable "vpc_cidr_block" {
  type        = string
  description = "cidr block for VPC addresses."
}

variable "subnets" {
  type = list(object({
    type              = string
    cidr_block        = string,
    availability_zone = string
  }))

  description = <<SNET
  Defines values requried to define subnets. There must be two availability zones. e.g.;
  [
    {
      type = "public-1",
      cidr_block = "10.0.1.0/24",
      availability_zone = "ap-southeast-2a"
    },
    {
      type = "private-1",
      cidr_block = "10.0.2.0/24",
      availability_zone = "ap-southeast-2b"
    }
  ]
  SNET
}

variable "iam_role_name" {
  type        = string
  description = "Role Name"
}

variable "assume_policy_role" {
  type = object({
    Version = string
    Statement = list(
      object({
        Action = string
        Effect = string
        Principal = object({
          Service = string
        })
      })
    ),
  })
}

variable "sg_name" {
  type        = string
  description = "Security Group Name"
}

variable "sg_description" {
  type        = string
  description = "Security Group Description"
}

variable "cluster_name" {
  type        = string
  description = "Name of the cluster"
} */

variable "tags" {
  type = map(string)
}
