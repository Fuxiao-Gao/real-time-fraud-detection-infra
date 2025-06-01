include {
  path = find_in_parent_folders()
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

terraform {
  source = "../../../modules/sagemaker_endpoint" 
}

dependency "s3_bucket" {
  config_path = "../s3_bucket"
}

inputs = {
  sagemaker_execution_role_name = "text-model-execution-role"
  sagemaker_policy_name         = "text-model-policy"
  sagemaker_policy_document = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject"
        ]
        Resource = [
          dependency.s3_bucket.outputs.s3_bucket_arn,
          "${dependency.s3_bucket.outputs.s3_bucket_arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ]
        Resource = "*"
      }
    ]
  })

  sagemaker_environment = {
    HF_MODEL_ID     = "austinb/fraud_text_detection"
    HF_TASK         = "text-classification"
  }

  sagemaker_model_name                  = "${local.env_vars.locals.prefix}-text-model"
  sagemaker_image_uri                   = local.env_vars.locals.sagemaker_text_repository_url
  repository_access_mode                = local.env_vars.locals.repository_access_mode
  sagemaker_endpoint_config_name        = "${local.env_vars.locals.prefix}-text-endpoint-config"
  sagemaker_initial_instance_count      = 1
  sagemaker_instance_type               = "ml.t2.medium"
  sagemaker_endpoint_name               = "${local.env_vars.locals.prefix}-text-endpoint"
}
