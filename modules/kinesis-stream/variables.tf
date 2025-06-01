# modules/kinesis-stream/variables.tf
variable "name" {
  description = "The name of the Kinesis stream"
  type        = string
}

# required if the stream_mode is set to 'PROVISIONED'
variable "shard_count" {
  description = "The number of shards in the Kinesis stream"
  type        = number
}

variable "stream_mode" {
  description = "The stream mode of the Kinesis stream"
  type        = string
  default     = "PROVISIONED"
}

variable "retention_period" {
  description = "The retention period of the stream in hours"
  type        = number
  default     = 24
}
