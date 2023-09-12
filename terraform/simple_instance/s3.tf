provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "dockingbay1" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    yor_name             = "dockingbay1"
    yor_trace            = "15e8b1d1-1db5-41b4-9883-5648497c26d4"
    git_commit           = "6bce365387ea1007f52dc943fb39ef1e15c61d93"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2023-09-12 19:53:55"
    git_last_modified_by = "57599263+kikeman26@users.noreply.github.com"
    git_modifiers        = "57599263+kikeman26"
    git_org              = "kikeman26"
    git_repo             = "terragoat"
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "dockingbay1" {
  bucket = aws_s3_bucket.dockingbay1.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
    }
  }
}