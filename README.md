Cloudfront module
==========================
This module is written in Terraform 0.12 to create Cloudfront distributiions using multiple origins (S3 or ALB) and dynamic
behaviour


Variables
---------
 - `environment`: Optional. To create an cloudfront name and using in the locals origin_id
 - `app_name`: Optional. To create an cloudfront name and using in the locals origin_id
 - `role`: Optional. To create an cloudfront name and using in the locals origin_id
 - `enable`: Mandatory. Boolean to enable the Cloudfront distribution or not. Defaults true
 - `is_ipv6_enabled`: Optional. Boolean to enable IPv6. Defaults true
 - `comment`: Optional. Description of your comment for your CloudFront
 - `default_root_object`: Optional. Root index object. Defaults empty
 - `aliases`: Optional.  Extra CNAMEs (alternate domain names), if any, for this distribution.
 - `restriction_type`: Mandatory for geo_restrictions. Defaults to none
 - `locations`: Mandatory if a geo_restriction is not set to none. Country codes: ISO 3166-1-alpha-2 codes
 - `price_class`: Optional. The price class for this distribution. Defaults to PriceClass_200
 - `cloudfront_default_certificate`: Mandatory. if you want viewers to use HTTPS to request your objects and you're using the CloudFront domain name for your distribution
 - `cloudfront_logging_enabled`: Optional. If set to true, a bucket must to be set. See logging_config. Defaults to false
 - `s3_origin_configs`: Mandatory. At least one origin must to be specified between `s3_origin_configs` or `custom_origin_configs`
 - `custom_origin_configs`: Mandatory. At least one origin must to be specified between `s3_origin_configs` or `custom_origin_configs`
 - `default_cache_behavior`: Mandatory. Default values has been set on `variables.tf`
 - `ordered_cache_behavior_variables`: Mandatory. Default values has been set on `variables.tf`
 - `waf_web_acl_id`: Optional. If provided it will be used and attached to distribution
 - `acm_certificate_arn_config`: Optional. If nothing is specified it goes to the default certificate. Viewer Certificate Arguments

Examples
--------
* Long example:

```hcl
module "cloudfront_dev" {
  source cesarpball/module

  app_name    = "app_name"
  role        = "frontend"
  environment = "dev"
  comment     = "app_name-frontend-dev created by Terraform"

  s3_origin_configs = [{
    domain_name            = aws_s3_bucket.bucket.bucket_regional_domain_name
    origin_path            = "/context"
    origin_id              = "S3-app_name-frontend-dev"
    origin_access_identity = aws_cloudfront_origin_access_identity.cf_origin_access_identity.cloudfront_access_identity_path

  }]

  default_cache_behavior = {

    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = "S3-app_name-frontend-dev"
    query_string           = false
    forward                = "none"
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  ordered_cache_behavior_variables = [{
    path_pattern           = "/"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = "S3-app_name-frontend-dev"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    #forwarded_values
    query_string = false
    headers      = ["Origin"]
    forward      = "none"

  }]


}
```
