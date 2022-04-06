output "bucket_arn" {
  value = aws_s3_bucket.aws_s3_bucket_backend.arn
}

output "bucket_id" {
  value = aws_s3_bucket.aws_s3_bucket_backend.id
}

output "dynamo_db_name" {
  value = aws_dynamodb_table.terraform_state_locking_dynamodb.name
}