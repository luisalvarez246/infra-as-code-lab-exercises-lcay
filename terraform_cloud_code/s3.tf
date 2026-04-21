resource "aws_s3_bucket" "example" {
  bucket = format("%s-bucket", var.prefix)
}