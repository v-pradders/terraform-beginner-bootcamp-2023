# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "cricket_website_bucket" {
  bucket = var.cricket_bucket_name

  tags = {
    user_uuid = var.user_uuid
  }
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration
resource "aws_s3_bucket_website_configuration" "cricket_website_configuration" {
  bucket = aws_s3_bucket.cricket_website_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
#/workspace/terraform-beginner-bootcamp-2023/public/assets/index.html
resource "aws_s3_object" "cricket_website_html_assets" {
  for_each = fileset("${var.root_path}/public/assets", "*.html")
  bucket = aws_s3_bucket.cricket_website_bucket.id
  key    = "${each.key}"
  source = "${var.root_path}/public/assets/${each.key}"
  content_type = "text/html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("${var.root_path}/public/assets/${each.key}")
}



# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution

locals {
  s3_origin_id = "myS3Origin"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control

resource "aws_cloudfront_origin_access_control" "cricket_website" {
  name   = "OAC ${aws_s3_bucket.cricket_website_bucket.bucket}"
  description  = "OAC for cricket Website ${aws_s3_bucket.cricket_website_bucket.bucket}"
  origin_access_control_origin_type = "s3"
  signing_behavior  = "always"
  signing_protocol  = "sigv4"
}

resource "aws_cloudfront_distribution" "cricket_website_s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.cricket_website_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.cricket_website.id
    origin_id                = local.s3_origin_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "cricket website cdn"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  tags = {
    user_uuid = var.user_uuid
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity

data "aws_caller_identity" "current" {}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy

resource "aws_s3_bucket_policy" "allow_access_from_CDN" {
  bucket = aws_s3_bucket.cricket_website_bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_CDN.json
}

data "aws_iam_policy_document" "allow_access_from_CDN" {
  statement {
        sid = "AllowCloudFrontServicePrincipal"
        effect = "Allow"
        principals {
                identifiers = ["cloudfront.amazonaws.com"]
                type = "Service"
        }
        actions = ["s3:GetObject"]
        resources = ["arn:aws:s3:::${aws_s3_bucket.cricket_website_bucket.id}/*"]
        condition {
            test     = "StringEquals"
            variable = "aws:SourceArn"
            values   = ["arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.cricket_website_s3_distribution.id}"]
        }
    }
}

resource "terraform_data" "invalidate_cache" {
  triggers_replace = var.invalidate_cache

  provisioner "local-exec" {
    # https://developer.hashicorp.com/terraform/language/expressions/strings#heredoc-strings
    command = <<COMMAND
aws cloudfront create-invalidation \
--distribution-id ${aws_cloudfront_distribution.cricket_website_s3_distribution.id} \
--paths '/*'
    COMMAND

  }
}