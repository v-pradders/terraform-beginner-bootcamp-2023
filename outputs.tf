output "cloudfront_url" {
  description = "CloudFront URL"
  value = module.cricket_static_website.cricket_domain_name
}