include {
  path = find_in_parent_folders()
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

dependency "kinesis_tagged"{
  config_path = "../kinesis_tagged"
}

dependency "s3_bucket"{
  config_path = "../s3_bucket"
}

dependency "glue_table"{
  config_path = "../glue_table"
}

terraform {
  source = "../../../modules/kinesis_firehose"
}

inputs = {
  firehose_name         = local.env_vars.locals.firehose_name
  destination           = "extended_s3"
  firehose_policy_document = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          Effect = "Allow",
          Action = [
            "s3:PutObject",
            "s3:PutObjectAcl",
            "s3:GetBucketLocation"
          ],
          Resource = [
            "${dependency.s3_bucket.outputs.s3_bucket_arn}",
            "${dependency.s3_bucket.outputs.s3_bucket_arn}/*"
          ]
        },
        {
          Effect = "Allow",
          Action = [
            "kinesis:DescribeStream",
            "kinesis:GetShardIterator",
            "kinesis:GetRecords",
            "kinesis:ListShards"
          ],
          Resource = [
            dependency.kinesis_tagged.outputs.stream_arn
          ]
        },
        {
          Effect = "Allow",
          Action = [
            "logs:PutLogEvents"
          ],
          Resource = "*"
        },
        {
          Effect = "Allow",
          Action = [
            "glue:GetTable",
            "glue:GetTableVersion",
            "glue:GetTableVersions",
            "glue:GetDatabase"
          ],
          Resource = [
            dependency.glue_table.outputs.glue_table_arn,
            dependency.glue_table.outputs.glue_database_arn,
            "arn:aws:glue:${local.env_vars.locals.region}:${local.env_vars.locals.account_id}:catalog",
          ]
        }
    ]})
  
  
  
  kinesis_source_stream_arn = dependency.kinesis_tagged.outputs.stream_arn
  enable_data_format_conversion = true
  data_format_conversion_input_format = "JSON"
  data_format_conversion_output_format = "PARQUET"

  enable_processing = true
  processors = [
    {
      type = "AppendDelimiterToRecord"
    }
  ]

  enable_destination_log = true
  destination_cw_log_group_name = "${local.env_vars.locals.firehose_name}-destination-log-group"
  destination_cw_log_stream_name = "${local.env_vars.locals.firehose_name}-destination-log-stream"
  destination_cw_log_retention_in_days = 1

  bucket_arn        = dependency.s3_bucket.outputs.s3_bucket_arn
  buffering_size    = 64
  bucket_prefix     = "${local.env_vars.locals.s3_posts_prefix}!{timestamp:yyyy}/!{timestamp:MM}/!{timestamp:dd}/!{timestamp:HH}/"
  bucket_error_output_prefix = "${local.env_vars.locals.s3_posts_prefix}error/"

  glue_database_name = dependency.glue_table.outputs.glue_database_name
  glue_table_name    = dependency.glue_table.outputs.glue_table_name
}