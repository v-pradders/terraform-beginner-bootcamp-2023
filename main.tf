resource "random_string" "bucket_name" {
  length           = 32
  special          = false
  lower            = true
  upper            = false
}

resource "aws_s3_bucket" "first_bucket" {
  bucket = random_string.bucket_name.id

}

resource "random_string" "cricket_bucket_name" {
  length           = 32
  special          = false
  lower            = true
  upper            = false
}

module "cricket_static_website" {
    source = "./modules/terrahouse_aws"

    cricket_bucket_name = var.cricket_bucket_name
    user_uuid = var.user_uuid
    root_path = var.root_path
    invalidate_cache = var.invalidate_cache

}

