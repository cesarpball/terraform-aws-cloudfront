Cloudfront module
==========================



Variables
---------
 TO-DO

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
