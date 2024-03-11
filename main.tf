terraform {
    required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.20.0"
      }
  }

    cloud {
    organization = "mrrb"

    workspaces {
      name = "vcs-terraform"
    }
  }

}

provider "aws" {
  region = "us-east-1"
}

module "apache" {
  source  = "TAREK199/apache-sample/aws"
  version = "1.0.0"
  vpc_id          = var.vpc_id
  my_ip_with_cidr = var.my_ip_with_cidr
  public_key      = var.public_key
  instance_type   = var.instance_type
  server_name     = var.server_name
}

resource "aws_s3_bucket" "vsc-bucket"{
  bucket = var.bucket_name 
}

output "public_ip" {
  value = module.apache.public_ip
}