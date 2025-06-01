output "glue_database_name" {
  value = aws_glue_catalog_database.this.name
}

output "glue_table_name" {
  value = aws_glue_catalog_table.this.name
}

output "glue_table_arn" {
  value = aws_glue_catalog_table.this.arn
}

output "glue_database_arn"{
  value = aws_glue_catalog_database.this.arn
}



