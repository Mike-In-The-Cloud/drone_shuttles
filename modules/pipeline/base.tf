# plan build
resource "aws_codebuild_project" "tf-plan" {
  name          = "tf-cicd-plan"
  description   = "Plan terraform IaC"
  service_role  = aws_iam_role.tf-codebuild-role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
  }
    
 source {
     type   = "CODEPIPELINE"
     buildspec = file("${path.module}/buildspec/plan-buildspec.yml")
 }
}

# apply build
resource "aws_codebuild_project" "tf-apply" {
  name          = "tf-cicd-apply"
  description   = "Build terraform IaC"
  service_role  = aws_iam_role.tf-codebuild-role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
  }
    
 source {
     type   = "CODEPIPELINE"
     buildspec = file("${path.module}/buildspec/apply-buildspec.yml")
 }
}

# destroy build
resource "aws_codebuild_project" "tf-destroy" {
  name          = "tf-cicd-destroy"
  description   = "Destroy terraform IaC"
  service_role  = aws_iam_role.tf-codebuild-role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
  }
    
 source {
     type   = "CODEPIPELINE"
     buildspec = file("${path.module}/buildspec/destroy-buildspec.yml")
 }
}

resource "aws_codepipeline" "cicd_pipeline" {

    name = "tf-cicd"
    role_arn = aws_iam_role.tf-codepipeline-role.arn

    artifact_store {
        type="S3"
        location = var.s3_id
    }

    stage {
        name = "Source"
        action{
            name = "Source"
            category = "Source"
            owner = "AWS"
            provider = "CodeStarSourceConnection"
            version = "1"
            output_artifacts = ["tf-code"]
            configuration = {
                FullRepositoryId = "Mike-In-The-Cloud/drone_shuttles"
                BranchName   = "dev-code-pipeline"
                ConnectionArn = var.codestar_connector_credentials
                OutputArtifactFormat = "CODE_ZIP"
            }
        }
    }
# build stage one
    stage {
        name ="Plan"
        action{
            name                = "Build"
            category            = "Build"
            provider            = "CodeBuild"
            version             = "1"
            owner               = "AWS"
            input_artifacts     = ["tf-code"]
            output_artifacts    = ["plan-output"]
            configuration       = {
                ProjectName     = "tf-cicd-plan"
            }
        }
    }
# manual approval
    stage {
        name = "Approve_Build"
        action {
            name     = "Approval"
            category = "Approval"
            owner    = "AWS"
            provider = "Manual"
            version  = "1"

        }
    }   

# build stage 2
    stage {
        name ="Deploy"
        action{
            name = "Deploy"
            category = "Build"
            provider = "CodeBuild"
            version = "1"
            owner = "AWS"
            input_artifacts = ["tf-code"]
            configuration = {
                ProjectName = "tf-cicd-apply"
            }
        }
    }

# manual approval     
    stage {
        name = "Approve_Destory"
        action {
            name     = "Approve_Destroy"
            category = "Approval"
            owner    = "AWS"
            provider = "Manual"
            version  = "1"

        }
    } 
    # destroy
    stage {
        name ="Destroy"
        action{
            name = "Destory"
            category = "Build"
            provider = "CodeBuild"
            version = "1"
            owner = "AWS"
            input_artifacts = ["tf-code"]
            configuration = {
                ProjectName = "tf-cicd-destory"
            }
        }
    } 


}
    