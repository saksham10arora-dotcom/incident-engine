# Azure Application Gateway TLS Binding (Old Certificate)
resource "azurerm_application_gateway" "network" {
  ssl_certificate {
    name     = "payment-cert-2025"
    data     = filebase64("old_cert.pfx")
  }
}
