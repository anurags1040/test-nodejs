data "google_storage_transfer_project_service_account" "default" {
  project = var.project_id
}


resource "google_storage_bucket" "s3-backup-bucket" {
  name          = "arg-bucket-1068-gcs-version"
  storage_class = "NEARLINE"
  project       = var.project_id
  location      = "US"
}

resource "google_storage_bucket_iam_member" "s3-backup-bucket" {
  bucket     = google_storage_bucket.s3-backup-bucket.name
  role       = "roles/storage.admin"
  member     = "serviceAccount:${data.google_storage_transfer_project_service_account.default.email}"
  depends_on = [google_storage_bucket.s3-backup-bucket]
}

# resource "google_pubsub_topic" "topic" {
#   name = "${var.pubsub_topic_name}"
# }

# resource "google_pubsub_topic_iam_member" "notification_config" {
#   topic = google_pubsub_topic.topic.id
#   role = "roles/pubsub.publisher"
#   member = "serviceAccount:${data.google_storage_transfer_project_service_account.default.email}"
# }

resource "google_storage_transfer_job" "s3-bucket-nightly-backup" {
  description = "test transfer of S3 bucket"
  project     = var.project_id

  transfer_spec {
    # object_conditions {
    #   max_time_elapsed_since_last_modification = "600s"
    #   # exclude_prefixes = [
    #   #   "requests.gz",
    #   # ]
    # }
    transfer_options {
      delete_objects_unique_in_sink = false
    }
    aws_s3_data_source {
      bucket_name = var.aws_s3_bucket
      # role_arn = var.role_arn
      aws_access_key {
        access_key_id     = jsondecode(file("key.json")).access_key
        secret_access_key = jsondecode(file("key.json")).secret_key
      }
    }
    gcs_data_sink {
      bucket_name = google_storage_bucket.s3-backup-bucket.name
      path        = ""
    }
  }

  schedule {
    schedule_start_date {
      year  = 2023
      month = 03
      day   = 27
    }
    schedule_end_date {
      year  = 2026
      month = 03
      day   = 28
    }
    start_time_of_day {
      hours   = 21
      minutes = 10
      seconds = 0
      nanos   = 0
    }
    repeat_interval = "3700s"
  }

  # notification_config {
  #   pubsub_topic  = google_pubsub_topic.topic.id
  #   event_types   = [
  #     "TRANSFER_OPERATION_SUCCESS",
  #     "TRANSFER_OPERATION_FAILED"
  #   ]
  #   payload_format = "JSON"
  # }

  depends_on = [google_storage_bucket_iam_member.s3-backup-bucket]
}