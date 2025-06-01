include {
  path = find_in_parent_folders()
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

dependency "ecr_lambda" {
  config_path = "../ecr_lambda"
}

dependency "s3_bucket" {
  config_path = "../s3_bucket"
}

dependency "cloudwatch_dashboard" {
  config_path = "../cloudwatch_dashboard"
}

dependency "kinesis_tagged" {
  config_path = "../kinesis_tagged"
}

dependency "kinesis_untagged" {
  config_path = "../kinesis_untagged"
}

dependency "sagemaker_media" {
  config_path = "../sagemaker_media"
}

dependency "sagemaker_text" {
  config_path = "../sagemaker_text"
}

terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-lambda.git?ref=v7.21.0"
}

inputs = {
  function_name = local.env_vars.locals.lambda_function_name
  create_package = false 
  
  # Docker image configuration
  package_type  = "Image"
  image_uri     = "${dependency.ecr_lambda.outputs.repository_url}:${local.env_vars.locals.image_tag}" 
  cloudwatch_logs_retention_in_days = 1
  
  # Lambda settings
  memory_size = 512
  timeout     = 300
  
  # Environment variables
  environment_variables = {
    KINESIS_STREAM_NAME           = dependency.kinesis_tagged.outputs.stream_name
    BUCKET_NAME                   = dependency.s3_bucket.outputs.s3_bucket_id
    SAGEMAKER_MEDIA_ENDPOINT_NAME = dependency.sagemaker_media.outputs.endpoint_name
    SAGEMAKER_TEXT_ENDPOINT_NAME  = dependency.sagemaker_text.outputs.endpoint_name
    METRIC_NAMESPACE              = local.env_vars.locals.prefix
  }
  
  # IAM permissions for Lambda to:
  # 1. Read from input Kinesis stream
  # 2. Write to output Kinesis stream
  # 3. Write to S3 bucket
  # 4. Send CloudWatch metrics
  # 5. Invoke SageMaker endpoints
  attach_policy_statements = true
  policy_statements = {
    kinesis_access = {
      effect    = "Allow",
      actions   = [
      "kinesis:GetRecords",
      "kinesis:GetShardIterator",
      "kinesis:DescribeStream",
      "kinesis:ListShards",
      "kinesis:PutRecord",
      "kinesis:PutRecords"
      ],
      resources = [
        dependency.kinesis_untagged.outputs.stream_arn,
        dependency.kinesis_tagged.outputs.stream_arn
      ]
    },
    s3_write = {
      effect    = "Allow",
      actions   = [
        "s3:PutObject",
        "s3:GetObject"
      ],
      resources = [
        dependency.s3_bucket.outputs.s3_bucket_arn,
        "${dependency.s3_bucket.outputs.s3_bucket_arn}/*"
      ]
    },
    cloudwatch_write_metrics = {
      effect    = "Allow",
      actions   = [
        "cloudwatch:PutMetricData"
      ],
      resources = ["*"]
    },
    sagemaker_invoke = {
      effect    = "Allow",
      actions   = [
        "sagemaker:InvokeEndpoint",
        "sagemaker:InvokeEndpointAsync"
      ],
      resources = ["*"]
    }
  }
  
  # Configure the event source mapping from Kinesis stream
  event_source_mapping = {
    kinesis = {
      event_source_arn  = dependency.kinesis_untagged.outputs.stream_arn
      starting_position = "LATEST"
      batch_size        = 8
      parallelization_factor = 5
      maximum_batching_window_in_seconds = 5
      maximum_retry_attempts = 0
    }
  }
  
}