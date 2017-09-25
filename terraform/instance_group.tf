resource "google_compute_instance_group_manager" "ml-instance-group-manager" {
  provider = "google.us-central1"
  name               = "ml-instance-group-manager"
  instance_template  = "${google_compute_instance_template.ml-instance-template.self_link}"
  base_instance_name = "ml-instance-group"
  zone               = "${var.region}-b" // TODO: multizone when TF 0.10.5 is released: https://github.com/terraform-providers/terraform-provider-google/issues/45

  named_port {
    name = "http"
    port = 80
  }

  auto_healing_policies {
    health_check = "${google_compute_http_health_check.ml-instance-health-check.self_link}"
    initial_delay_sec = 600
  }
}

resource "google_compute_autoscaler" "ml-autoscaler" {
  provider = "google.us-central1"
  name   = "ml-autoscaler"
  zone   = "${var.region}-b" // TODO: multizone when TF 0.10.5 is released: https://github.com/terraform-providers/terraform-provider-google/issues/45
  target = "${google_compute_instance_group_manager.ml-instance-group-manager.self_link}"

  autoscaling_policy = {
    max_replicas    = 3 // cant be more due to global IP addr assignment
    min_replicas    = 1
    cooldown_period = 600

    cpu_utilization {
      target = 0.8
    }
  }
}