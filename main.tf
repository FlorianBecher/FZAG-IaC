terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.65"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  subscription_id = "0b98c131-13b9-47a5-adba-a8d9db7c041b"
  client_id       = "93b6740f-2cc0-45f1-ba5b-d5d3aefbefc0"
  client_secret   = "tG58Q~BxG5rSJTvcIFLDfXhsxbE43RnqmxUvEcaI"
  tenant_id       = "5842708c-024d-4e2b-afe2-a803f3cb25dd"
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    environement = "dev"
    source       = "Terraform"
    owner        = "Florian"
  }
}
resource "azurerm_app_service_plan" "appserviceplan" {
  name                = "FZAG-IaC-FBE-WebApp-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Free"
    size = "F1"
  }
}
resource "azurerm_app_service" "webapp" {
  name                = "FZAG-IaC-FBE-WebApp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id
  source_control {
    repo_url           = "https://github.com/FlorianBecher/FZAG-IaC"
    branch             = "master"
    manual_integration = true
    use_mercurial      = false
  }
}