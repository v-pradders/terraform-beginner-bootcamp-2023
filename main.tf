terraform {
  cloud {
    organization = "prad-learner"
    workspaces {
      name = "terra-town"
    }
  }  
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "random" {
  # Configuration options
}

provider "aws" {
  # Configuration options
}

resource "random_string" "bucket_name" {
  length           = 32
  special          = false
  lower            = true
  upper            = false
}

output "s3_bucket_name" {
  value = random_string.bucket_name.id
}

resource "aws_s3_bucket" "first_bucket" {
  bucket = random_string.bucket_name.id

}
