output "firehose_stream_name" {
  description = "The name of the Firehose delivery stream."
  value       = aws_kinesis_firehose_delivery_stream.this.name
}

output "firehose_stream_arn" {
  description = "The ARN of the Firehose delivery stream."
  value       = aws_kinesis_firehose_delivery_stream.this.arn
}

output "firehose_role_arn" {
  description = "The ARN of the IAM role assumed by Firehose."
  value       = aws_iam_role.firehose_role.arn
}
