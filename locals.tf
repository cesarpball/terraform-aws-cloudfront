# ID

locals {
  origin_id        = "${var.origin_id != "" ? var.origin_id : "S3-${var.app_name}-${var.role}-${var.environment}"}"
  target_origin_id = "${var.target_origin_id != "" ? var.target_origin_id : var.origin_id}"
}

# Logging config enabled
locals {
  cloudfront_logging_configs = {
    enabled = [{
      bucket          = var.logging_config["bucket"]
      include_cookies = var.logging_config["include_cookies"]
      prefix          = var.logging_config["prefix"]
    }]

    disabled = []

  }
  enable_logging = var.cloudfront_logging_enabled == true ? "enabled" : "disabled"
}
