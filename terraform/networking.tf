data "google_compute_network" "ml-default-network" {
  provider = "google.us-central1"
  name = "default"
}

resource "google_compute_firewall" "ml-firewall" {
  provider = "google.us-central1"
  name    = "ml-firewall"
  network = "${data.google_compute_network.ml-default-network.name}"

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_tags = ["http-server", "https-server"]
}

resource "google_compute_address" "ml-ip-address" {
  provider = "google.us-central1"
  name = "ml-ip-address"
  region = "${var.region}"
}