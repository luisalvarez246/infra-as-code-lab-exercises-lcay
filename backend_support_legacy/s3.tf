resource "aws_s3_bucket" "tf_state_bucket" {
  bucket        = "${var.prefix}-tfstate"
  force_destroy = true
  tags = {
    Name = "${var.prefix}-tfstate"
  }
}

resource "aws_s3_bucket_versioning" "versioning_tf_state_bucket" {
  bucket = aws_s3_bucket.tf_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption_tf_state_bucket" {
  bucket = aws_s3_bucket.tf_state_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block_tf_state_bucket" {
  bucket = aws_s3_bucket.tf_state_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}