//resource "null_resource" "appengine-app-deployer" {
//  provisioner "local-exec" {
//    command = <<EOT
//        gcloud app create \
//          --region=us-central \
//          --project=${var.google_project_id} \
//           --quiet || true
//    EOT
//  }
//
//  provisioner "local-exec" {
//    command = <<EOT
//        gcloud app deploy \
//          --project ${var.google_project_id} \
//          --promote \
//          --stop-previous-version \
//          --quiet \
//          ../appengine-image-updater/app.yaml \
//          ../appengine-image-updater/cron.yaml
//    EOT
//  }
//
//
//}