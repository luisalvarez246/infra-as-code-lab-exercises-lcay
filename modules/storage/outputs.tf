output "db_address" {
  description = "The address of the database"
  value       = aws_db_instance.database.address
}

output "secret_arn" {
  description = "The ARN of the database secret"
  value       = data.aws_secretsmanager_secret.db.arn
}

output "secret_key_id" {
  description = "The key ID of the database secret"
  value       = data.aws_secretsmanager_secret_version.db.version_id
}