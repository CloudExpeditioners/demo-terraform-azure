terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-demo"
    storage_account_name = "stacctfstatedemo001"
    container_name       = "tfstate"
    key                  = "dev/demo.terraform.tfstate"
  }
}
