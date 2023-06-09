############################### Azure CDN ################################
resource "azurerm_cdn_profile" "cdn_profile" {
  name                = "${var.backend_role}-cdn-profile-${var.name_env}"
  resource_group_name = var.rg_name
  location            = "global"
  tags = {
    "Name"        = var.finance_product
    "Role"        = "${var.backend_role}-${var.name_env}"
    "Environment" = var.finance_env
  }

  sku = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "cdn_endpoint" {
  name                = "${var.backend_role}-cdn-endpoint-${var.name_env}"
  resource_group_name = var.rg_name
  location            = "global"
  tags = {
    "Name"        = var.finance_product
    "Role"        = "${var.backend_role}-${var.name_env}"
    "Environment" = var.finance_env
  }

  profile_name           = azurerm_cdn_profile.cdn_profile.name
  optimization_type      = "GeneralWebDelivery"
  is_compression_enabled = true
  content_types_to_compress = [
    "text/plain",
    "text/html",
    "text/css",
    "text/javascript",
    "text/js",
    "application/x-javascript",
    "application/javascript",
    "application/json",
    "application/xml",
    "image/vnd.microsoft.icon",
    "image/svg+xml"
  ]

  origin_host_header = azurerm_storage_account.storage_account_for_cdn.primary_web_host

  origin {
    name      = "${var.backend_role}-storage-origin-${var.name_env}"
    host_name = azurerm_storage_account.storage_account_for_cdn.primary_web_host
  }

  delivery_rule {
    name  = "SPAUrlRewrite"
    order = 1
    url_file_extension_condition {
      operator     = "LessThan"
      match_values = ["1"]
    }

    url_rewrite_action {
      source_pattern          = "/"
      destination             = "/index.html"
      preserve_unmatched_path = false
    }
  }
}