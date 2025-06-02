locals {
  environment = "dev"

  account_id = get_env("AWS_ACCOUNT_ID", "")
  account_id_non_empty = (
    length(local.account_id) > 0
  ) ? local.account_id : error("AWS_ACCOUNT_ID environment variable is required but not set!")
  
  region     = "us-east-1"

  # Common prefix for resource naming
  prefix     = "fraud-detect-${local.environment}"
  
  # Kinesis Stream names
  kinesis_untagged = "${local.prefix}-untagged-stream"
  kinesis_tagged   = "${local.prefix}-tagged-stream"

  # shard counts
  kinesis_untagged_shard_count = 120
  kinesis_tagged_shard_count   = 1

  # Lambda function names
  lambda_function_name = "${local.prefix}-lambda-processor"
  
  # Firehose delivery stream names
  firehose_name        = "${local.prefix}-firehose"
  
  # ECS settings
  ecs_cluster_name     = "${local.prefix}-cluster"
  ecs_service_name     = "${local.prefix}-ecs-processor"
  ecs_log_group_prefix = "/ecs/${local.prefix}"
  
  # Docker image specifications
  ecs_processor_repository      = "${local.prefix}-ecs-processor-repository"
  lambda_processor_repository   = "${local.prefix}-lambda-processor-repository"
  image_tag                     = get_env("IMAGE_TAG", "")
  image_tag_non_empty = (
    length(local.image_tag) > 0
  ) ? local.image_tag : error("IMAGE_TAG environment variable is required but not set!")

  # sagemaker settings
  sagemaker_text_repository_url       = "763104351884.dkr.ecr.us-east-1.amazonaws.com/huggingface-pytorch-inference:2.1.0-transformers4.37.0-cpu-py310-ubuntu22.04"
  sagemaker_media_repository_url      = "763104351884.dkr.ecr.us-east-1.amazonaws.com/huggingface-pytorch-inference:2.1.0-transformers4.37.0-cpu-py310-ubuntu22.04"
  repository_access_mode              = "Platform"

  # Container specifications
  fargate_cpu        = 512
  fargate_memory     = 1024

  # glue database name
  glue_database_name = "${local.prefix}-glue-database"
  glue_table_name    = "${local.prefix}-glue-table"

  # s3 prefixes
  s3_posts_prefix = "posts/"
  s3_media_prefix = "media/"
}