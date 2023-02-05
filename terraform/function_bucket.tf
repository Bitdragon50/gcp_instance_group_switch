resource "google_storage_bucket" "bucket" {
  name     = "${var.name_prefix}-bucket"
  location = "EU"
}

resource "google_storage_bucket_object" "switch_off_archive" {
  name   = "switch_off.zip"
  bucket = google_storage_bucket.bucket.name
  source = "./switch_off.zip"
}

resource "google_storage_bucket_object" "switch_on_archive" {
  name   = "switch_on.zip"
  bucket = google_storage_bucket.bucket.name
  source = "./switch_on.zip"
}

data "archive_file" "switch_off" {
  type        = "zip"
  source_dir  = "./function_code/switch_off"
  output_path = "./switch_off.zip"
}

data "archive_file" "switch_on" {
  type        = "zip"
  source_dir  = "./function_code/switch_on"
  output_path = "./switch_on.zip"
}