# modules/kinesis-stream/outputs.tf
output "stream_arn" {
  value = aws_kinesis_stream.this.arn
}

output "stream_name" {
  value = aws_kinesis_stream.this.name
}