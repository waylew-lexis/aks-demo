provider "azurerm" {
  storage_use_azuread = true
  # infra-sandbox
  subscription_id = "b0837458-adf3-41b0-a8fb-c16f9719627d"
  features {}
}



provider "azuread" {

}