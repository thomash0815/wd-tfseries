#appservice plan

variable "appserviceplan_name" {
  description = "The name of the App Service Plan."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group where the App Service Plan exists."
  type        = string
}

variable "os_type" {
  description = "The O/S type for the App Services"
  type        = string
  default     = "Linux"  
}

variable "sku_name" {
  description = "Service Plan SKU"
  type = string
  default = "S1"
}

variable "tags" {
  description = "Tags to set"
  type        = map(string)
}

#webapp

variable "webapp_name" {
  description = "The name which should be used for this Linux Web App"
  type        = string
}

variable "location" {
  description = "The Region where the Web App should exist."
  type        = string
  default     = "North Europe"
}

variable "https_only" {
  description = "Should the Linux Web App require HTTPS connections."
  type        = bool
  default     = true
}

variable "ftps_state" {
  description = "The State of FTP / FTPS service"
  type        = string
  default     = "Disabled"
  
}

variable "identity_type" {
  description = "Specifies the type of Managed Service Identity that should be configured on this Linux Web App"
  type        = string
  default     = "SystemAssigned"
  
}

variable "storage_account" {
  type = object({
    name         = string
    type         = string
    account_name = string
    share_name   = string
    access_key   = string
    mount_path   = string
  })
  default = {
    name         = ""
    type         = ""
    account_name = ""
    share_name   = ""
    access_key   = ""
    mount_path   = ""
  }
}
