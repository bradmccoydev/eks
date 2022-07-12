# ---------------------------------------------------------------------------------------------------------------------
# AWS Network
# ---------------------------------------------------------------------------------------------------------------------

module "aws_vpc" {
  source     = "github.com/bradmccoydev?ref=release-0.0.1-modules//aws/aws_vpc?ref=tags/v0.0.4"
  cidr_block = var.cidr_block
  tags       = merge(local.tags, var.cloud_custom_tags)
}

module "aws_eip" {
  source = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/elastic_ip?ref=tags/v0.0.4"
  vpc    = true
}

module "aws_internet_gateway" {
  source = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/internet_gateway?ref=tags/v0.0.4"
  vpc_id = module.aws_vpc.id
  tags   = merge(local.tags, var.cloud_custom_tags)
}

module "aws_subnet_public_1" {
  source            = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/subnet?ref=tags/v0.0.4"
  vpc_id            = module.aws_vpc.id
  cidr_block        = var.public_subnet_cidr_block_1
  availability_zone = var.availability_zone_1
}

module "aws_subnet_public_2" {
  source            = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/subnet?ref=tags/v0.0.4"
  vpc_id            = module.aws_vpc.id
  cidr_block        = var.public_subnet_cidr_block_2
  availability_zone = var.availability_zone_2
}

module "aws_subnet_private_1" {
  source = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/subnet?ref=tags/v0.0.4"
  for_each = {
    var.availability_zone_1 = var.private_subnet_cidr_block_1,
    var.availability_zone_2 = var.private_subnet_cidr_block_2
  }

  availability_zone = each.key
  cidr_block        = each.value
  vpc_id            = module.aws_vpc.id
}

module "aws_route_table_public" {
  source = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/route_table?ref=tags/v0.0.4"
  vpc_id = module.aws_vpc.id
}

module "aws_route_table_private" {
  source = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/route_table?ref=tags/v0.0.4"
  vpc_id = module.aws_vpc.id
}

module "aws_route_public" {
  source                 = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/route?ref=tags/v0.0.4"
  route_table_id         = module.aws_route_table_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.aws_internet_gateway.id
}

module "aws_route_private" {
  source                 = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/route?ref=tags/v0.0.4"
  route_table_id         = module.aws_route_table_private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.aws_internet_gateway.id
}

module "aws_nat_gateway" {
  source        = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/nat_gateway?ref=tags/v0.0.4"
  allocation_id = module.aws_eip.id
  subnet_id     = module.aws_subnet_public_1.id
}

module "aws_route_table_association_private" {
  source = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/aws_route_table_association?ref=tags/v0.0.4"
  for_each = toset([
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ])
  subnet_id      = each.value
  route_table_id = module.aws_route_private.id
}

module "aws_route_table_association_public" {
  source = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/aws_route_table_association?ref=tags/v0.0.4"
  for_each = toset([
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ])

  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}
