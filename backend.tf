terraform {
  cloud {
    organization = "dotcomrow"

    workspaces {
      name = "ecommerced-store-terraform-workspace"
    }
  }
}