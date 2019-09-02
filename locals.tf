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

# Certificate
locals {
  acm_certificate_arn_configs = {
    acm_certificate_arn_enable = [{
      acm_certificate_arn            = var.acm_certificate_arn_config["acm_certificate_arn"]
      minimum_protocol_version       = var.acm_certificate_arn_config["minimum_protocol_version"]
      ssl_support_method             = var.acm_certificate_arn_config["ssl_support_method"]
      cloudfront_default_certificate = false
    }]

    acm_certificate_arn_disable = [{
      cloudfront_default_certificate = var.cloudfront_default_certificate
      acm_certificate_arn            = var.acm_certificate_arn_config["acm_certificate_arn"]
      minimum_protocol_version       = var.acm_certificate_arn_config["minimum_protocol_version"]
      ssl_support_method             = var.acm_certificate_arn_config["ssl_support_method"]
    }]
  }
  enable_certificate = var.acm_certificate_arn_config["acm_certificate_arn"] != null ? "acm_certificate_arn_enable" : "acm_certificate_arn_disable"
}
