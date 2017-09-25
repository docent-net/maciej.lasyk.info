resource "google_compute_global_address" "ml-glb-ip" {
  provider = "google.us-central1"
  name = "ml-glb-ip"
}

resource "google_compute_backend_service" "ml-glb-backend" {
  provider = "google.us-central1"
  name        = "ml-glb-backend"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 30
  enable_cdn  = true
  connection_draining_timeout_sec = 300

  // has to do it manually as it is provided by local-exec:
  depends_on = ["null_resource.ml-instance-group-manager","null_resource.ml-instance-group-manager-autoscaling","null_resource.ml-instance-group-manager-named-ports"]

  backend {
    group = "projects/${var.google_project_id}/regions/${var.region}/instanceGroups/ml-instance-group-manager"
  }

  health_checks = ["${google_compute_http_health_check.ml-instance-health-check.self_link}"]
}

resource "google_compute_url_map" "ml-glb" {
  provider = "google.us-central1"
  name            = "ml-glb"
  default_service = "${google_compute_backend_service.ml-glb-backend.self_link}"

  host_rule {
    hosts        = ["*"]
    path_matcher = "catchall"
  }

  path_matcher {
    name            = "catchall"
    default_service = "${google_compute_backend_service.ml-glb-backend.self_link}"
  }
}

resource "google_compute_target_http_proxy" "ml-glb-target-http-proxy" {
  provider = "google.us-central1"
  name        = "ml-glb-target-http-proxy"
  url_map     = "${google_compute_url_map.ml-glb.self_link}"
}

resource "google_compute_target_https_proxy" "ml-glb-target-https-proxy" {
  provider = "google.us-central1"
  name        = "ml-glb-target-https-proxy"
  url_map     = "${google_compute_url_map.ml-glb.self_link}"
  // hardcoded cert (and created manually in console) as Terraform GCP provider doesn't handle
  // properly certs generated by Letsencrypt yet :(
  ssl_certificates = ["projects/${var.google_project_id}/global/sslCertificates/ml-ssl-cert"]
}

resource "google_compute_global_forwarding_rule" "ml-glb-forwarding-rule" {
  provider = "google.us-central1"
  name = "ml-glb-http-frontend"
  target = "${google_compute_target_http_proxy.ml-glb-target-http-proxy.self_link}"
  ip_address = "${google_compute_global_address.ml-glb-ip.self_link}"
  port_range = "80"
}

resource "google_compute_global_forwarding_rule" "ml-glb-ssl-forwarding-rule" {
  provider = "google.us-central1"
  name = "ml-glb-https-frontend"
  target = "${google_compute_target_https_proxy.ml-glb-target-https-proxy.self_link}"
  ip_address = "${google_compute_global_address.ml-glb-ip.self_link}"
  port_range = "443"
}