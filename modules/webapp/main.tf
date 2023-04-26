resource "azurerm_service_plan" "appserviceplan" {
  name                         = var.appserviceplan_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  os_type                      = var.os_type
  sku_name                     = var.sku_name
  tags                         = var.tags
}


resource "azurerm_linux_web_app" "webapp" {
  name                  = var.webapp_name
  resource_group_name   = var.resource_group_name
  location              = var.location
  service_plan_id       = azurerm_service_plan.appserviceplan.id
  https_only            = var.https_only
  tags                  = var.tags

  site_config {
    ftps_state = var.ftps_state
  }

  identity {
    type = var.identity_type
  }

  dynamic storage_account {
    for_each = var.storage_account.name == "" ? [] : [1]
    content {
      name         = var.storage_account.name
      type         = var.storage_account.type
      account_name = var.storage_account.account_name
      share_name   = var.storage_account.share_name
      access_key   = var.storage_account.access_key
      mount_path   = var.storage_account.mount_path
    }
  }
}

