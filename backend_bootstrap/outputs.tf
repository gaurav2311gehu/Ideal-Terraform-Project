output "s3_bucket_name" {
  description = "Name of the created s3 bucket"
  value = aws_s3_bucket.mybucket.bucket
}

output "dynamodb_table_name" {
  description = "Name of the created DynamoDB table"
  value = aws_dynamodb_table.terraform_locks.name
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value = aws_s3_bucket.mybucket.arn
}

output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table"
  value = aws_dynamodb_table.terraform_locks.arn
}