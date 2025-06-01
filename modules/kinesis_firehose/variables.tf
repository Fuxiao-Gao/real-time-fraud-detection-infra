variable "firehose_policy_document" {
  description = "IAM policy document for Kinesis Firehose"
  type        = string
}

variable "firehose_name" {
  description = "Name of the Kinesis Firehose delivery stream"
  type        = string
}

variable "kinesis_source_stream_arn" {
  description = "Kinesis stream ARN for Firehose"
  type        = string
}

variable "destination" {
  description = "Destination for Kinesis Firehose"
  type        = string
  default     = "extended_s3"
}

variable "bucket_arn" {
  description = "S3 bucket ARN for Firehose"
  type        = string
}

variable "bucket_prefix" {
  description = "S3 bucket prefix for Firehose"
  type        = string
}

variable "bucket_error_output_prefix" {
  description = "S3 bucket error output prefix for Firehose"
  type        = string
}

variable "buffering_size" {
  description = "Buffering size for Firehose"
  type        = number
  default     = 5
}

variable "glue_database_name" {
  description = "Glue database name for Firehose"
  type        = string
}

variable "glue_table_name" {
  description = "Glue table name for Firehose"
  type        = string
}

variable "enable_data_format_conversion" {
  description = "Enable data format conversion"
  type        = bool
  default     = false
}

variable "data_format_conversion_input_format" {
  description = "Input format for data format conversion"
  type        = string
  default     = "JSON"
}

variable "data_format_conversion_hive_timestamps" {
  description = "Hive JSON SerDe timestamp formats"
  type        = list(string)
  default     = []
}

variable "data_format_conversion_output_format" {
  description = "Output format for data format conversion"
  type        = string
  default     = "PARQUET"
}

variable "data_format_conversion_parquet_compression" {
  description = "Parquet compression for data format conversion"
  type        = string
  default     = "SNAPPY"
}

variable "enable_processing" {
  description = "Enable processing for Firehose"
  type        = bool
  default     = false
}

variable "processors" {
  description = "Processors for Firehose"
  type = any
  default = null
}

variable "enable_destination_log" {
  description = "Enable destination log for Firehose"
  type        = bool
  default     = false
}

variable "destination_cw_log_group_name" {
  description = "CloudWatch log group name for Firehose destination"
  type        = string
  default     = ""
}

variable "destination_cw_log_stream_name" {
  description = "CloudWatch log stream name for Firehose destination"
  type        = string
  default     = ""
}

variable "destination_cw_log_retention_in_days" {
  description = "CloudWatch log retention in days for Firehose destination"
  type        = number
  default     = 1
}