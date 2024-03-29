resource "google_compute_instance_group_manager" "ml-nha-instance-group-manager" {
  provider = "google.us-central1"
  name               = "ml-nha-instance-group-manager"
  instance_template  = "${google_compute_instance_template.ml-instance-template.self_link}"
  base_instance_name = "ml-nha-instance-group"
  zone               = "${var.zone}"

  named_port {
    name = "http"
    port = 80
  }

  auto_healing_policies {
    health_check = "${google_compute_http_health_check.ml-instance-health-check.self_link}"
    initial_delay_sec = 600
  }
}

resource "google_compute_autoscaler" "ml-nha-autoscaler" {
  provider = "google.us-central1"
  name   = "ml-nha-autoscaler"
  zone   = "${var.zone}"
  target = "${google_compute_instance_group_manager.ml-nha-instance-group-manager.self_link}"

  autoscaling_policy = {
    max_replicas    = 1
    min_replicas    = 1
    cooldown_period = 600

    cpu_utilization {
      target = 0.8
    }
  }
}