resource "google_service_account" "ml-instance-service-account" {
  provider = "google.us-central1"
  account_id   = "ml-vms"
}

data "google_iam_policy" "ml-instance-service-account-iam-policy" {
  provider = "google.us-central1"
  binding {
    role = "roles/storage.objectViewer"

    members = [
      "serviceAccount:${google_service_account.ml-instance-service-account.email}",
    ]
  }
}

resource "google_project_iam_policy" "ml-instance-project-iam-policy" {
  provider = "google.us-central1"
  project     = "${var.google_project_id}"
  policy_data = "${data.google_iam_policy.ml-instance-service-account-iam-policy.policy_data}"
}