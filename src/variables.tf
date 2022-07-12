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

variable "client_project_repo" {
  description = "Project source control repository"
}

variable "cloud_tenant_id" {
  description = "Tenant ID"
  type        = string
}

variable "cloud_account_id" {
  description = "Subscription ID"
  type        = string
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

variable "tags" {
  type = map(string)
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
