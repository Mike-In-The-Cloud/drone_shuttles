resource "aws_s3_bucket" "codepipeline_artifacts" {
  bucket = "pipeline-artifacts-casestudy-test"
  acl    = "private"

  tags = {
    Name = "${terraform.workspace}-S3-Artifact-Bucket"
  }
} 
