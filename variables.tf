variable install_ingress {
    description = "Whether to create ingress-nginx resources"
    type = bool
    default = false
}


variable chart_version {
    description = "Version of the chart to deploy. 4.x requires K8S 1.19+, for older versions use version 3.40.0"
    type = string
    default = "4.0.13"
}

variable namespace {
    default = "ingress-nginx"
    description = "What namespace to create controller in."
    type = string
}

variable create_namespace {
    type = bool
    default = true
    description = "Whether to create namespace if it doesn't exist."
}

variable ingress_class {
    type = string
    default = "nginx"
    description = "Ingress class label. Useful for targeting a specific ingress controller."
}

variable enable_ssl_passthrough {
    type = bool
    description = "Whether to enable SSL passthrough to underlying service."
    default = true
}

variable default_certificate {
    type = string
    description = "Default TLS certificate to use with controller, in format <namespace>/<secret_name>"
    default = null
}

variable autoscaling_configuration {
    type = object({
        enabled = string
        minReplicas = string
        maxReplicas = string
        targetCPUUtilizationPercentage = string
        targetMemoryUtilizationPercentage =  string
    })
    default = {
        enabled = "false"
        minReplicas = "1"
        maxReplicas = "11"
        targetCPUUtilizationPercentage = "50"
        targetMemoryUtilizationPercentage =  "50"
    }
}

variable enable_internal_lb {
    type = bool
    default = false
    description = "Enable internal Load Balancer."
}


variable enable_external_lb {
    type = bool
    default = true
    description = "Enable external Load Balancer."
}