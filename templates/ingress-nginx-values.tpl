controller:
  autoscaling:
    ${indent(4,autoscaling_conf)}
  extraArgs:
    enable-ssl-passthrough: ${enable_ssl_passthrough}
    default-ssl-certificate: ${default_certificate}
  ingressClassResource: 
    name: ${ingress_class}
  external:
    enabled: ${enable_external_lb}
  internal:
    enabled: ${enable_internal_lb}
  service:
    annotations:
      service.beta.kubernetes.io/aws-load-balancer-backend-protocol: tcp
      service.beta.kubernetes.io/aws-load-balancer-cross-zone-load-balancing-enabled: 'true'
      service.beta.kubernetes.io/aws-load-balancer-type: ${lb_type}