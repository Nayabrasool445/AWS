# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "my-first-pipeline"
resource "aws_codepipeline" "my-first-pipeline" {
  name     = "my-first-pipeline"
  role_arn = "arn:aws:iam::127552426662:role/service-role/AWSCodePipelineServiceRole-us-east-1-my-first-pipeline"
  tags     = {}
  tags_all = {}
  artifact_store {
    location = "codepipeline-us-east-1-712573730310"
    region   = null
    type     = "S3"
  }
  stage {
    name = "Source"
    action {
      category = "Source"
      configuration = {
        BranchName           = "main"
        OutputArtifactFormat = "CODE_ZIP"
        PollForSourceChanges = "false"
        RepositoryName       = "my-demo-repo"
      }
      input_artifacts  = []
      name             = "Source"
      namespace        = "SourceVariables"
      output_artifacts = ["SourceArtifact"]
      owner            = "AWS"
      provider         = "CodeCommit"
      region           = "us-east-1"
      role_arn         = null
      run_order        = 1
      version          = "1"
    }
  }
  stage {
    name = "Deploy"
    action {
      category = "Deploy"
      configuration = {
        ActionMode         = "CREATE_UPDATE"
        Capabilities       = "CAPABILITY_NAMED_IAM"
        OutputFileName     = "Nayab.json"
        ParameterOverrides = "{\"InstanceType\": \"t2.micro\"}"
        RoleArn            = "arn:aws:iam::127552426662:role/my-admin-role"
        StackName          = "my-demo-stack"
        TemplatePath       = "SourceArtifact::demo-ec2.yaml"
      }
      input_artifacts  = ["SourceArtifact"]
      name             = "Deploy"
      namespace        = "DeployVariables"
      output_artifacts = ["deploy-output"]
      owner            = "AWS"
      provider         = "CloudFormation"
      region           = "us-east-1"
      role_arn         = null
      run_order        = 1
      version          = "1"
    }
  }
}
