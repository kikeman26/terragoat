provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "dockingbay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name        = "Docking Bay"
    Environment = "Dev"
    yor_name    = "dockingbay"
    yor_trace   = "15e8b1d1-1db5-41b4-9883-5648497c26d4"
  }
}
