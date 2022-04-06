resource "aws_kms_key" "s3_backend_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 30
}

resource "aws_kms_alias" "s3_backend_key_alias" {
  name          = "alias/TerraformBackend/Casestudy"
  target_key_id = aws_kms_key.s3_backend_key.key_id
}

resource "aws_s3_bucket" "aws_s3_bucket_backend" {
  bucket = "dev-droneshuttles-casestudy-backend"
}

resource "aws_s3_bucket_acl" "s3_acl" {
  bucket = aws_s3_bucket.aws_s3_bucket_backend.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse_s3" {
  bucket = aws_s3_bucket.aws_s3_bucket_backend.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.s3_backend_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "versioning_s3" {
  bucket = aws_s3_bucket.aws_s3_bucket_backend.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_state_locking_dynamodb" {
  name           = "Droneshuttles-backend"
  hash_key       = "LockID"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "LockID"
    type = "S"
  }
}