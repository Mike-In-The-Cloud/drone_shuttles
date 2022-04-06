resource "aws_s3_bucket" "codepipeline_artifacts" {
  bucket = "pipeline-artifacts-casestudy-test"

  tags = {
    Name = "${terraform.workspace}-S3-Artifact-Bucket"
  }
} 
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }

}