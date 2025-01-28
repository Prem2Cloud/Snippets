/*
    This terraform configration is purely for demonstration purposes only and is not written to best practices.
    We recommend that you take the example configuration and merge it with your existing terraform configuration.
*/


// ----- Configure the Terraform Backend
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~>2.5"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>3.0"
    }
  }
  backend "local" {}
}

// ----- Configure the Azure AD Provider
provider "azuread" {
  tenant_id = "YOUR_TENANT_ID_HERE"
}
