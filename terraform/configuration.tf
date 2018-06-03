terraform {
  required_version = ">= 0.10.4"
  backend "gcs" {
    bucket = "ml-terraform-states"
    path = "maciej.lasyk.info"
    project = "maciej-lasyk-info"
  }
}

variable google_project_id {
  type = "string"
  default = "maciej-lasyk-info"
}

variable region {
  type = "string"
  default = "us-central1"
}

variable zone {
  type = "string"
  default = "us-central1-a"
}

provider "google" {
  project = "${var.google_project_id}"
  region = "${var.region}"
  alias = "us-central1"
}

variable ml-cloud_storage_bucket_name {
  type = "string"
  default = "ml-maciej-lasyk-info"
}
