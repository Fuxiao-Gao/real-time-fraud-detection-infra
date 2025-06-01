# modules/kinesis-stream/main.tf
resource "aws_kinesis_stream" "this" {
  name             = var.name
  shard_count      = var.stream_mode != "ON_DEMAND" ? var.shard_count : null
  retention_period = var.retention_period

  stream_mode_details {
    stream_mode = var.stream_mode
  }
}

