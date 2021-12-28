

locals {
    chart_values = templatefile("${path.module}/templates/ingress-nginx-values.tpl",
    {
        lb_type = "nlb"
        enable_ssl_passthrough = var.enable_ssl_passthrough
        default_certificate = "${var.default_certificate == null ? "" : var.default_certificate}"
        ingress_class = var.ingress_class
        autoscaling_conf = yamlencode(var.autoscaling_configuration)
        enable_internal_lb = var.enable_internal_lb
        enable_external_lb = var.enable_external_lb
    })
}

resource "helm_release" "ingress_nginx" {


count = var.install_ingress ? 1 : 0
name = "ingress-nginx"
repository = "https://kubernetes.github.io/ingress-nginx"
chart = "ingress-nginx"
version = var.chart_version 
namespace = var.namespace
create_namespace = var.create_namespace

values = [ 
    local.chart_values
]

#add Prometheus support.
}