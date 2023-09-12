provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "dockingbay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name        = "Docking Bay"
    Environment = "Dev"
    yor_name    = "dockingbay"
    yor_trace   = "8215da6e-dfa8-44b3-8d9c-c8c8c4fa14fd"
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "dockingbay" {
  bucket = aws_s3_bucket.dockingbay.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "dockingbay" {
  bucket = aws_s3_bucket.dockingbay.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "dockingbay_destination" {
  # checkov:skip=CKV_AWS_144:the resource is auto generated to be a destination for replication
  bucket = aws_s3_bucket.dockingbay.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_iam_role" "dockingbay_replication" {
  name = "aws-iam-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_replication_configuration" "dockingbay" {
  depends_on = [aws_s3_bucket_versioning.dockingbay]
  role   = aws_iam_role.dockingbay_replication.arn
  bucket = aws_s3_bucket.dockingbay.id
  rule {
    id = "foobar"
    status = "Enabled"
    destination {
      bucket        = aws_s3_bucket.dockingbay_destination.arn
      storage_class = "STANDARD"
    }
  }
}

resource "aws_s3_bucket" "dockingbay_log_bucket" {
  bucket = "dockingbay-log-bucket"
}

resource "aws_s3_bucket_logging" "dockingbay" {
  bucket = aws_s3_bucket.dockingbay.id

  target_bucket = aws_s3_bucket.dockingbay_log_bucket.id
  target_prefix = "log/"
}
