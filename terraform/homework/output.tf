data "kubernetes_service" "homework_service" {
  metadata {
    name      = var.homework_app_chart_name
    namespace = "homework"
  }

  depends_on = [ helm_release.homework-app ] 
}

output "url_homework_geolocation" {
    description = "URL to geolocation service exposed by NLB"
    value = "http://${data.kubernetes_service.homework_service.status[0].load_balancer[0].ingress[0].hostname}"
}

output "url_homework_index_html" {
    description = "URL to echo service exposed by NLB"
    value = "http://${data.kubernetes_service.homework_service.status[0].load_balancer[0].ingress[0].hostname}/index.html"
}