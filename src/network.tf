# ---------------------------------------------------------------------------------------------------------------------
# AWS Network
# ---------------------------------------------------------------------------------------------------------------------

module "aws_vpc" {
  source = "github.com/bradmccoydev/terraform-modules//aws/aws_vpc?ref=0.0.1"
  cidr_block = var.cidr_block
  tags = var.tags
} 

# resource "aws_security_group" "app_servers" {
#   name        = "app-servers"
#   description = "For application servers"
#   vpc_id      = data.aws_vpc.default.id
# }

# resource "aws_security_group_rule" "allow_access" {
#   type                     = "ingress"
#   from_port                = module.aurora.this_rds_cluster_port
#   to_port                  = module.aurora.this_rds_cluster_port
#   protocol                 = "tcp"
#   source_security_group_id = aws_security_group.app_servers.id
#   security_group_id        = module.aurora.this_security_group_id
# }

module "aws_eip" {
  source = "./modules/aws/network/elastic_ip/terraform"
  vpc = true
} 

module "aws_internet_gateway" {
  source  = "./modules/aws/network/internet_gateway/terraform"
  vpc_id  = module.aws_vpc.id
  tags    = var.tags
} 

module "aws_subnet_public_1" {
  source = "./modules/aws/network/subnet/terraform"
  vpc_id             = module.aws_vpc.id
  cidr_block         = var.public_subnet_cidr_block_1
  availability_zone  = var.availability_zone_1
} 

module "aws_subnet_public_2" {
  source = "./modules/aws/network/subnet/terraform"
  vpc_id             = module.aws_vpc.id
  cidr_block         = var.public_subnet_cidr_block_2
  availability_zone  = var.availability_zone_2
} 

module "aws_subnet_private_1" {
  source = "./modules/aws/network/subnet/terraform"
  vpc_id             = module.aws_vpc.id
  cidr_block         = var.private_subnet_cidr_block_1
  availability_zone  = var.availability_zone_1
} 

module "aws_subnet_private_2" {
  source = "./modules/aws/network/subnet/terraform"
  vpc_id             = module.aws_vpc.id
  cidr_block         = var.private_subnet_cidr_block_2
  availability_zone  = var.availability_zone_2
} 

module "aws_route_table_public" {
  source  = "./modules/aws/network/route_table/terraform"
  vpc_id  = module.aws_vpc.id
} 

module "aws_route_public" {
  source  = "./modules/aws/network/route/terraform"
  route_table_id         = module.aws_route_table_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.aws_internet_gateway.id
} 

module "aws_route_table_private" {
  source  = "./modules/aws/network/route_table/terraform"
  vpc_id  = module.aws_vpc.id
} 

module "aws_route_private" {
  source  = "./modules/aws/network/route/terraform"
  route_table_id         = module.aws_route_table_private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.aws_internet_gateway.id
} 

module "aws_nat_gateway" {
  source  = "./modules/aws/network/nat_gateway/terraform"
  allocation_id = module.aws_eip.id
  subnet_id     = module.aws_subnet_public_1.id
} 

module "aws_route_table_association_private_1" {
  source  = "./modules/aws/network/aws_route_table_association/terraform"
  subnet_id     = module.aws_subnet_private_1.id
  route_table_id = module.aws_route_private.id
} 

module "aws_route_table_association_private_2" {
  source  = "./modules/aws/network/aws_route_table_association/terraform"
  subnet_id     = module.aws_subnet_private_2.id
  route_table_id = module.aws_route_private.id
} 

module "aws_route_table_association_public_1" {
  source  = "./modules/aws/network/aws_route_table_association/terraform"
  subnet_id     = module.aws_subnet_public_1.id
  route_table_id = module.aws_route_public.id
} 

module "aws_route_table_association_public_2" {
  source  = "./modules/aws/network/aws_route_table_association/terraform"
  subnet_id     = module.aws_subnet_public_2.id
  route_table_id = module.aws_route_public.id
} 