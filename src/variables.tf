variable "client_id" {
  description = "Client ID"
}

variable "client_name" {
  description = "Client Name"
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

variable "client_project_repo" {
  description = "Project source control repository"
}

variable "cloud_account_id" {
  description = "Subscription ID"
  type        = string
}

variable "cloud_location_1" {
  description = "Cloud Location (region)"
}

variable "cloud_transient_instance" {
  description = "The environment"
}

variable "bastion_ips_to_whitelist" {
  description = "Bastion IP's to Whitelist"
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

# Network
variable "cidr_block" {
  description = "VPC Cidr block"
  default     = "10.1.0.0/16"
}

variable "public_subnet_cidr_block_1" {
  description = "public subnet 1 CIDR block"
  default     = "10.1.10.0/24"
}

variable "public_subnet_cidr_block_2" {
  description = "public subnet 2 CIDR block"
  default     = "10.1.20.0/24"
}

variable "private_subnet_cidr_block_1" {
  description = "private subnet 1 CIDR block"
  default     = "10.1.50.0/24"
}

variable "private_subnet_cidr_block_2" {
  description = "private subnet 2 CIDR block"
  default     = "10.1.60.0/24"
}

variable "availability_zone_1" {
  description = "Availability zone 1"
  default     = "us-west-2a"
}

variable "availability_zone_2" {
  description = "Availability zone 2"
  default     = "us-west-2b"
}

variable "kubernetes_node_disk_size" {
  description = "Node Disk Size"
  type = number
  default = 30
}
