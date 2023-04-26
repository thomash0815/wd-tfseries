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


# calling web app module to create web app
module "webapp" {
  source              = "./modules/webapp"
  webapp_name         = var.webapp_name
  resource_group_name = azurerm_resource_group.webapp-rg.name
  location            = azurerm_resource_group.webapp-rg.location
  appserviceplan_name = var.appserviceplan_name
  sku_name            = var.sku_name
  os_type             = var.os_type
  identity_type       = var.identity_type
  tags                = var.tags
}



