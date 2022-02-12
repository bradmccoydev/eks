module "azurerm_key_vault_primary" {
  source = "github.com/bradmccoydev/terraform-modules//azurerm/azurerm_key_vault"
  name                       = "${local.shared_name}-aks"
  resource_group_name        = module.azurerm_resource_group.name
  location                   = var.cloud_location_1.name
  tenant_id                  = var.cloud_tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  sku_name                   = "standard"

  tags = merge(local.tags, var.cloud_custom_tags)
}
