provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "docking_bay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    yor_name             = "docking_bay"
    yor_trace            = "8215da6e-dfa8-44b3-8d9c-c8c8c4fa14fd"
    git_commit           = "bab74ff918ba07336e3101d92c13399419950b26"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2023-09-12 19:00:33"
    git_last_modified_by = "57599263+kikeman26@users.noreply.github.com"
    git_modifiers        = "57599263+kikeman26"
    git_org              = "kikeman26"
    git_repo             = "terragoat"
  }
}
