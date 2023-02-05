resource "google_cloud_scheduler_job" "switch_OFF_IG" {

  name             = "${var.name_prefix}-off-job"
  description      = "Schedule to switch off instance groups during the weekend"
  schedule         = "0 1 * * 6"
  time_zone        = var.time_zone
  attempt_deadline = "320s"

  retry_config {
    retry_count = 2
  }

  http_target {
    http_method = "POST"
    uri         = google_cloudfunctions_function.switch_off.https_trigger_url
    oidc_token {
    service_account_email = var.service_account
    }
  }
}

resource "google_cloud_scheduler_job" "switch_ON_IG" {

  name             = "${var.name_prefix}-on-job"
  description      = "Schedule to switch on instance groups during the weekend"
  schedule         = "0 1 * * 1"
  time_zone        = var.time_zone
  attempt_deadline = "320s"

  retry_config {
    retry_count = 2
  }

  http_target {
    http_method = "POST"
    uri         = google_cloudfunctions_function.switch_on.https_trigger_url
    oidc_token {
    service_account_email = var.service_account
    }
  }
}