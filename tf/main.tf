# valid for terraform version 0.13
# provider "azurerm" {
#   version = "=2.40.0"
#   features {}
# }

# valid for terraform versions >= 0.14
provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

resource "azurerm_resource_group" "checkov_demo" {
  name     = "checkov_demo-resources"
  location = "West Europe"
}

resource "azurerm_storage_account" "checkov_demo" {
  name                     = "checkovdemo123"
  resource_group_name      = azurerm_resource_group.checkov_demo.name
  location                 = azurerm_resource_group.checkov_demo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "checkov"
  }
}

resource "azurerm_storage_container" "checkov_demo" {
  name                  = "checkov-demo"
  storage_account_name  = azurerm_storage_account.checkov_demo.name
  container_access_type = "private"
}
