variable "cricket_bucket_name" {
  type        = string
  description = "The name of the S3 bucket for cricket data."
}

variable "user_uuid" {
  type        = string
  description = "exampro uuid"
}

variable "root_path" {
  type        = string
  description = "root_path"
}

variable "invalidate_cache" {
  type        = number
  description = "increment number if cache required"
}