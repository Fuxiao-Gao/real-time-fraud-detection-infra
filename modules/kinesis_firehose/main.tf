# define the trust policy for the Firehose role
data "aws_iam_policy_document" "firehose_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Let firehose assume the role
resource "aws_iam_role" "firehose_role" {
  name               = "firehose_role"
  assume_role_policy = data.aws_iam_policy_document.firehose_assume_role.json
}

# iam policy for firehose to access other resources
resource "aws_iam_policy" "firehose_policy" {
  name        = "firehose_role_policy"
  description = "Policy for Firehose to access S3 and Kinesis"
  policy      = var.firehose_policy_document
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "firehose_role_policy" {
  role       = aws_iam_role.firehose_role.name
  policy_arn = aws_iam_policy.firehose_policy.arn
}

resource "aws_cloudwatch_log_group" "firehose_log_group" {
  name              = var.destination_cw_log_group_name
  retention_in_days = var.destination_cw_log_retention_in_days
}

resource "aws_cloudwatch_log_stream" "firehose_log_stream" {
  name           = var.destination_cw_log_stream_name
  log_group_name = aws_cloudwatch_log_group.firehose_log_group.name
}

resource "aws_kinesis_firehose_delivery_stream" "this" {
  name        = var.firehose_name
  destination = var.destination

  dynamic "kinesis_source_configuration" {
    for_each = var.kinesis_source_stream_arn != null ? [true] : []
    content {
      kinesis_stream_arn = var.kinesis_source_stream_arn
      role_arn           = aws_iam_role.firehose_role.arn
    }
  }

  dynamic "extended_s3_configuration" {
    for_each = try(var.bucket_arn, null) != null ? [true] : []
    content {
      role_arn            = aws_iam_role.firehose_role.arn
      bucket_arn          = var.bucket_arn
      prefix              = try(var.bucket_prefix, null)
      error_output_prefix = try(var.bucket_error_output_prefix, null)
      buffering_size      = try(var.buffering_size, null)

      dynamic "processing_configuration" {
        for_each = var.enable_processing ? [true] : []
        content {
          enabled = var.enable_processing

          dynamic "processors" {
            for_each = try(var.processors, null) != null ? var.processors : []
            content {
              type = processors.value["type"]
              
              dynamic "parameters" {
                for_each = try(processors.value["parameters"], null) != null ? processors.value["parameters"] : []
                content {
                  parameter_name  = parameters.value["name"]
                  parameter_value = parameters.value["value"]
                }
              }
            }
          }
        }
      }     
      
      dynamic "data_format_conversion_configuration" {
        for_each = var.enable_data_format_conversion? [true] : []
        content {
          input_format_configuration {
            deserializer {
              dynamic "hive_json_ser_de" {
                for_each              = var.data_format_conversion_input_format == "JSON" ? [true] : []
                content {
                  timestamp_formats   = try(var.data_format_conversion_hive_timestamps, null)
                }
              }
            }
          }

          output_format_configuration {
            serializer {
              dynamic "parquet_ser_de" {
                for_each              = var.data_format_conversion_output_format == "PARQUET" ? [true] : []
                content {
                  compression         = try(var.data_format_conversion_parquet_compression, null)
                }
              }
            }
          }

          schema_configuration {
            database_name = var.glue_database_name
            role_arn      = aws_iam_role.firehose_role.arn
            table_name    = var.glue_table_name
          }
        }
      }

      dynamic "cloudwatch_logging_options" {
        for_each = var.enable_destination_log ? [true] : []
        content {
          enabled         = var.enable_destination_log
          log_group_name  = aws_cloudwatch_log_group.firehose_log_group.name
          log_stream_name = aws_cloudwatch_log_stream.firehose_log_stream.name
        }
      }
    }
  }
}

