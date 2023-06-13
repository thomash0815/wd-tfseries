terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.10.0"
    }

  }
}
provider "azurerm" {

  features {}
}

resource "azurerm_resource_group" "webapp-rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "webapp" {
  source = "git::https://github.com/thomash0815/tf-modules.git//webapp?ref=5387396" #v.1.0.0" #feature/demochange" #"./modules/webapp"

  for_each            = var.webapp_names_list 
  webapp_name         = each.value
  resource_group_name = azurerm_resource_group.webapp-rg.name
  location            = azurerm_resource_group.webapp-rg.location
  appserviceplan_name = "sp-${each.value}"
  sku_name            = var.sku_name
  os_type             = var.os_type
  identity_type       = var.identity_type
  tags                = var.tags
}

#webapp_name         = var.webapp_name
#"${var.appserviceplan_name}-${index(var.webapp_names_list, each.value)}"
#toset(var.webapp_names_list)

output "webapp_id" {
  value = values(module.webapp)[*].webapp_id  
}

#value = module.webapp.webapp_id



