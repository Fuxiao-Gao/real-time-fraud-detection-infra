resource "aws_glue_catalog_database" "this" {
  name = var.database_name
}

resource "aws_glue_catalog_table" "this" {
  name          = var.table_name
  database_name = aws_glue_catalog_database.this.name

  table_type = "EXTERNAL_TABLE"
 
  dynamic "storage_descriptor" {
    for_each = var.storage_descriptor != null? [true] : []

    content {
      bucket_columns            = try(var.storage_descriptor.bucket_columns, null)
      compressed                = try(var.storage_descriptor.compressed, null)
      input_format              = try(var.storage_descriptor.input_format, null)
      location                  = try(var.storage_descriptor.location, null)
      number_of_buckets         = try(var.storage_descriptor.number_of_buckets, null)
      output_format             = try(var.storage_descriptor.output_format, null)
      parameters                = try(var.storage_descriptor.parameters, null)
      stored_as_sub_directories = try(var.storage_descriptor.stored_as_sub_directories, null)

      dynamic "columns" {
        for_each = try(var.storage_descriptor.columns, null) != null ? var.storage_descriptor.columns : []

        content {
          name       = columns.value.name
          comment    = try(columns.value.comment, null)
          parameters = try(columns.value.parameters, null)
          type       = try(columns.value.type, null)
        }
      }
    }
  }
}
