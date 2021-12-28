# EKS Ingress Nginx module for AWS

WARNING: Still in progress, so bound to change often! Do not use this in production (yet)!

## Description

This is a simple module for creating a cookie-cutter ingress-nginx resource via official Helm chart.

## Examples

An example using an eks module to provision a cluster (https://github.com/mskender/aws-terraform-eks):
```
module "k8s" {
    region = "eu-west-1"
    source = "github.com/mskender/aws-terraform-eks"
    cluster_name = local.cluster_name
    eks_subnet_ids = module.network.public_subnets.*.id
    
    write_kube_config = true
    kube_config_location = local.kubeconfig_loc
    export_kube_config = false
    shellrc_file = "~/.customization"
}

module "ingress_nginx" {
    install_ingress = true
    source = "github.com/mskender/aws-terraform-eks-ingress-nginx"

    enable_external_lb = true
    enable_internal_lb = true
    ingress_class = "nginx"
    namespace = "ingress-nginx"
    create_namespace = true
    autoscaling_configuration = {
            enabled = "true"
            minReplicas = "1"
            maxReplicas = "5"
            targetCPUUtilizationPercentage = "50"
            targetMemoryUtilizationPercentage =  "50"
    }

    providers = {
        helm = helm.eks
    }
}
```

Providers are aliased so the location of kube config file is not checked until eks cluster is created and config dumped via "k8s" module in example above:
```
provider kubectl {
    alias = "eks"
    config_path = local.kubeconfig_loc
    
}
provider helm {
    alias = "eks"
    kubernetes{
        config_path = local.kubeconfig_loc
    }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=3.38.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.ingress_nginx](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoscaling_configuration"></a> [autoscaling\_configuration](#input\_autoscaling\_configuration) | n/a | <pre>object({<br>        enabled = string<br>        minReplicas = string<br>        maxReplicas = string<br>        targetCPUUtilizationPercentage = string<br>        targetMemoryUtilizationPercentage =  string<br>    })</pre> | <pre>{<br>  "enabled": "false",<br>  "maxReplicas": "11",<br>  "minReplicas": "1",<br>  "targetCPUUtilizationPercentage": "50",<br>  "targetMemoryUtilizationPercentage": "50"<br>}</pre> | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Version of the chart to deploy. 4.x requires K8S 1.19+, for older versions use version 3.40.0 | `string` | `"4.0.13"` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Whether to create namespace if it doesn't exist. | `bool` | `true` | no |
| <a name="input_default_certificate"></a> [default\_certificate](#input\_default\_certificate) | Default TLS certificate to use with controller, in format <namespace>/<secret\_name> | `string` | `null` | no |
| <a name="input_enable_external_lb"></a> [enable\_external\_lb](#input\_enable\_external\_lb) | Enable external Load Balancer. | `bool` | `true` | no |
| <a name="input_enable_internal_lb"></a> [enable\_internal\_lb](#input\_enable\_internal\_lb) | Enable internal Load Balancer. | `bool` | `false` | no |
| <a name="input_enable_ssl_passthrough"></a> [enable\_ssl\_passthrough](#input\_enable\_ssl\_passthrough) | Whether to enable SSL passthrough to underlying service. | `bool` | `true` | no |
| <a name="input_ingress_class"></a> [ingress\_class](#input\_ingress\_class) | Ingress class label. Useful for targeting a specific ingress controller. | `string` | `"nginx"` | no |
| <a name="input_install_ingress"></a> [install\_ingress](#input\_install\_ingress) | Whether to create ingress-nginx resources | `bool` | `false` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | What namespace to create controller in. | `string` | `"ingress-nginx"` | no |

## Outputs

No outputs.
