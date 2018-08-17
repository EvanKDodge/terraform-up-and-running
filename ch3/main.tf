provider "aws" {
    region = "us-west-1"
}

resource "aws_s3_bucket" "terraform_state" {
    bucket = "${var.bucket_name}"

    versioning {
        enabled = true
    }
}

# this section was added after terraform apply was run on the above code
terraform {
  backend "s3" {
    bucket  = "terraform-up-and-running-state-aug2018"
    region  = "us-west-1"
    key     = "terraform.tfstate"
    encrypt = true    
  }
}
