module "bastion" {
  count  = var.cloud_location_1_bastion_enabled  ? 1 : 0
  source = "git::https://github.com/bradmccoydev/terraform-modules.git//aws/aws_bastion?ref=tags/v0.0.9"

  name             = local.primary_name
  vpc_id           = var.cidr_block
  subnet_id        = module.network.public_subnet_1
  ips_to_whitelist = var.bastion_ips_to_whitelist.*.ip
  instance_type    = "t2.micro"
  user_data        = <<-EOF
    #!/bin/bash
    apt update && apt upgrade
    sudo apt install traceroute
  EOF

  tags = merge(local.common_tags, var.custom_tags)
}