resource "google_cloudfunctions_function" "switch_off" {
  name        = "${var.name_prefix}-off-fxn"
  description = "This function turns off instance groups"
  runtime     = "python39"

  available_memory_mb          = 128
  source_archive_bucket        = google_storage_bucket.bucket.name
  source_archive_object        = google_storage_bucket_object.switch_off_archive.name
  trigger_http                 = true
  https_trigger_security_level = "SECURE_ALWAYS"
  timeout                      = 60
  entry_point                  = "switch"
}

resource "google_cloudfunctions_function" "switch_on" {
  name        = "${var.name_prefix}-on-fxn"
  description = "This function turns on instance groups"
  runtime     = "python39"

  available_memory_mb          = 128
  source_archive_bucket        = google_storage_bucket.bucket.name
  source_archive_object        = google_storage_bucket_object.switch_on_archive.name
  trigger_http                 = true
  https_trigger_security_level = "SECURE_ALWAYS"
  timeout                      = 60
  entry_point                  = "switch"
}