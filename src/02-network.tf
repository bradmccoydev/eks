# ---------------------------------------------------------------------------------------------------------------------
# AWS Network
# ---------------------------------------------------------------------------------------------------------------------
module "network" {
  source               = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/network?ref=tags/v0.1.0"
  cidr_block           = var.cidr_block
  public_subnet_cidrs  = ["10.1.10.0/24", "10.1.20.0/24"]
  private_subnet_cidrs = ["10.1.50.0/24", "10.1.60.0/24"]
  availability_zones   = ["us-west-2a", "us-west-2b"]

  tags = merge(local.tags, var.cloud_custom_tags)
}
