# Outputs

output "cloudfront_id" {
  value = aws_cloudfront_distribution.cf_distribution.id
}

output "cloudfront_arn" {
  value = aws_cloudfront_distribution.cf_distribution.arn
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.cf_distribution.domain_name
}

output "hosted_zone_id" {
  value = aws_cloudfront_distribution.cf_distribution.hosted_zone_id
}
