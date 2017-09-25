resource "null_resource" "ml-instance-group-manager" {
  provisioner "local-exec" {
    command = <<EOT
        gcloud beta compute instance-groups managed
        create ml-instance-group-manager-test
        --size=1
        --template=${google_compute_instance_template.ml-instance-template.name}
        --base-instance-name=ml-instance-group
        --initial-delay=600
        --http-health-check=${google_compute_http_health_check.ml-instance-health-check.name}
        --region=${var.region}
    EOT
  }
}

resource "null_resource" "ml-instance-group-manager" {
  provisioner "local-exec" {
    command = <<EOT
        gcloud beta compute instance-groups managed
        set-named-ports ml-instance-group-manager
        --named-ports="http:80"
        --region=${var.region}
    EOT
  }
}

resource "null_resource" "ml-instance-group-manager" {
  provisioner "local-exec" {
    command = <<EOT
        gcloud beta compute instance-groups managed
        set-autoscaling ml-instance-group-manager
        --cool-down-period=600
        --max-num-replicas=3
        --min-num-replicas=1
        --scale-based-on-cpu
        --target-cpu-utilization=0.6
        --region=${var.region}
    EOT
  }
}

// No support for region in Terraform / GCP modules in below resources. Need
// To wait until TF 0.11.0

//resource "google_compute_instance_group_manager" "ml-instance-group-manager" {
//  provider = "google.us-central1"
//  name               = "ml-instance-group-manager"
//  instance_template  = "${google_compute_instance_template.ml-instance-template.self_link}"
//  base_instance_name = "ml-instance-group"
//  zone               = "${var.region}"
//
//  named_port {
//    name = "http"
//    port = 80
//  }
//
//  auto_healing_policies {
//    health_check = "${google_compute_http_health_check.ml-instance-health-check.self_link}"
//    initial_delay_sec = 600
//  }
//}
//
//resource "google_compute_autoscaler" "ml-autoscaler" {
//  provider = "google.us-central1"
//  name   = "ml-autoscaler"
//  zone   = "${var.region}"
//  target = "${google_compute_instance_group_manager.ml-instance-group-manager.self_link}"
//
//  autoscaling_policy = {
//    max_replicas    = 3 // cant be more due to global IP addr assignment
//    min_replicas    = 1
//    cooldown_period = 600
//
//    cpu_utilization {
//      target = 0.8
//    }
//  }
//}