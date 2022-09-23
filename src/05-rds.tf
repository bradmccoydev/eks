module "rds" {
  source = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/aws_rds_instance?ref=tags/v0.0.9"

  name              = local.shared_name
  db_name           = "metabase"
  db_username       = "metabase"
  vpc_id            = module.network.vpc_id
  subnet_ids        = [module.network.private_subnet_1, module.network.private_subnet_2]
  db_instance_class = "db.t3.medium"
  engine            = "postgres"
  engine_version    = "14.3"
  allocated_storage = "30"
  ip_whitelist      = var.bastion_ips_to_whitelist.*.ip

  tags = merge(local.tags, var.cloud_custom_tags)
}