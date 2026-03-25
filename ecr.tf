resource "aws_ecr_repository" "api" {
  name         = format("%s-ecr-repo", var.prefix)
  force_delete = true

  tags = {
    Name = format("%s-crud-app", var.prefix)
  }

  image_scanning_configuration {
    scan_on_push = true
  }
}