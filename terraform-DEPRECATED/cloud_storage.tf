resource "google_storage_bucket" "ml-cloud_storage_bucket" {
  provider = "google.us-central1"
  name     = "${var.ml-cloud_storage_bucket_name}"
  location = "US"
  storage_class = "MULTI_REGIONAL"
  force_destroy = true
}

resource "google_storage_bucket_acl" "ml-cloud_storage_bucket-acl" {
  provider = "google.us-central1"
  bucket = "${google_storage_bucket.ml-cloud_storage_bucket.name}"
  depends_on = ["google_service_account.ml-instance-service-account"]

  role_entity = [
    "READER:user-${google_service_account.ml-instance-service-account.email}"
  ]
}

data "template_file" "ml-nginx_startup_template" {
  template = "${path.module}/templates/nginx_startup.sh.tpl"
  vars {
    bucket_name = "${google_storage_bucket.ml-cloud_storage_bucket.name}"
  }
}

resource "google_storage_bucket_object" "ml-nginx_startup" {
  provider = "google.us-central1"
  name   = "ml-nginx_startup.sh"
  source = "${data.template_file.ml-nginx_startup_template.rendered}"
  bucket = "${google_storage_bucket.ml-cloud_storage_bucket.name}"
}

resource "google_storage_bucket_object" "ml-nginx_health_check_conf" {
  provider = "google.us-central1"
  name   = "ml-nginx_health_check.conf"
  source = "${path.module}/templates/nginx_health_check.conf"
  bucket = "${google_storage_bucket.ml-cloud_storage_bucket.name}"
}
