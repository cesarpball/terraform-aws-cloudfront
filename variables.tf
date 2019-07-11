variable "app_name" {
  default = ""
}

variable "role" {
  default = "cf"
}

variable "environment" {
  default = ""
}

variable "enable" {
  default = true
}

variable "is_ipv6_enabled" {
  default = true
}

variable "comment" {
  default = "Cloudfront distribution created by Terraform"
}

variable "default_root_object" {
  default = "index.html"
}


#Origin

variable "domain_name" {
  default = ""
}

variable "origin_id" {
  default = ""
}


variable "origin_access_identity" {
  default = ""
}

# Loggig config
variable "include_cookies" {
  default = false
}

variable "bucket" {
  default = ""
}

variable "prefix" {
  default = ""
}
#
variable "aliases" {
  default     = []
  description = "Extra CNAMEs (alternate domain names), if any, for this distribution."
  type        = list(string)
}

# default_cache_behavior
variable "allowed_methods" {
  default     = ["GET", "HEAD", "OPTIONS"]
  description = "HTTP, GET"
  type        = list(string)
}

variable "cached_methods" {
  default     = ["GET", "HEAD", "OPTIONS"]
  description = "HTTP, GET"
  type        = list(string)
}
variable "target_origin_id" {
  default = ""
}

# forwarded_values
variable "query_string" {
  default = false
}
# cookies
variable "forward" {
  default = "none"
}

variable "viewer_protocol_policy" {
  default = false
}

#geo_restriction

variable "restriction_type" {
  default = "none"
}
variable "locations" {
  type        = list(string)
  default     = []
  description = "The ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content: https://www.iso.org/obp/ui/#search"
}


variable "price_class" {
  default = "PriceClass_200"
}

variable "cloudfront_default_certificate" {
  type    = bool
  default = true
}

# Logging configuration optional
variable "cloudfront_logging_enabled" {
  type        = bool
  default     = false
  description = "If true, mandatory values are needed"
}

variable "logging_config" {

  default = {
    bucket          = null
    include_cookies = null
    prefix          = null
  }
}


variable "s3_origin_configs" {

  type        = list(map(string))
  description = "Define values for origin or multiple origins"
  default     = []
}

variable "custom_origin_configs" {

  type        = list(map(string))
  description = "Define values for origin or multiple origins"
  default     = []
}

variable "default_cache_behavior" {

  default = {

    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = ""
    query_string           = false
    forward                = "none"
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
}

variable "ordered_cache_behavior_variables" {
  default = [
    {
      path_pattern           = "/"
      allowed_methods        = ["GET", "HEAD", "OPTIONS"]
      cached_methods         = ["GET", "HEAD", "OPTIONS"]
      target_origin_id       = ""
      min_ttl                = 0
      default_ttl            = 86400
      max_ttl                = 31536000
      compress               = true
      viewer_protocol_policy = "redirect-to-https"
      #forwarded_values
      query_string = false
      headers      = ["Origin"]
      forward      = "none"

    },
    {
      path_pattern           = "/content/test2/*"
      allowed_methods        = ["GET", "HEAD", "OPTIONS"]
      cached_methods         = ["GET", "HEAD", "OPTIONS"]
      target_origin_id       = ""
      min_ttl                = 0
      default_ttl            = 86400
      max_ttl                = 31536000
      compress               = true
      viewer_protocol_policy = "redirect-to-https"
      #forwarded_values
      query_string = false
      headers      = ["Origin"]
      forward      = "none"

    },
  ]
}

