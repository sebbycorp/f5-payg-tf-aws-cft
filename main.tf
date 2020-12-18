
terraform {
  backend "s3" {
    bucket         = "f5-payg-aws-cft-tf-env"
    key            = "f5-payg-aws-cft-tf-env.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "f5-payg-aws-cft-tf-env-state-lock"
  }
}

resource "aws_s3_bucket" "f5-payg-aws-cft-tf-env-s3" {
  bucket = "f5-payg-aws-cft-tf-env-s3"
  acl    = "private"

  versioning {
    enabled = true
  }
}
resource "aws_s3_bucket_object" "f5-payg-aws-cft-tf-env-s3-object" {
  key                    = "f5-payg-cft.json"
  bucket                 = aws_s3_bucket.f5-payg-aws-cft-tf-env-s3.id
  source                 = "f5-payg-cft.json"
  server_side_encryption = "aws:kms"
}


