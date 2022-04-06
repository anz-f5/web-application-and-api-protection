# Health Check
resource "volterra_healthcheck" "this" {
  name      = "healthcheck-http"
  namespace = var.volterra_namespace

  http_health_check {
    use_origin_server_name = true
    path                   = "/"
    use_http2              = false
  }

  healthy_threshold   = "3"
  interval            = "15"
  timeout             = "3"
  unhealthy_threshold = "1"
}

# Origin Pool
resource "volterra_origin_pool" "this" {
  name                   = format("%s-ori-pool", var.web_app_name)
  namespace              = var.volterra_namespace
  description            = format("Origin pool pointing to origin server %s", var.origin_server_dns_name[0])
  loadbalancer_algorithm = "ROUND ROBIN"
  origin_servers {
    public_name {
      dns_name = var.origin_server_dns_name[0]
    }
  }
  port               = 443
  endpoint_selection = "LOCAL_PREFERRED"
  use_tls {
    no_mtls                  = true
    volterra_trusted_ca      = true
    skip_server_verification = true

    disable_sni            = false
    use_host_header_as_sni = true
    sni                    = var.origin_server_sni
    tls_config {
      default_security = true
      low_security     = false
      medium_security  = false
    }
  }
  healthcheck {
    name      = "healthcheck-http"
    namespace = var.volterra_namespace
  }
}

# HTTP Load Balancer
resource "volterra_http_loadbalancer" "this" {
  depends_on                      = [volterra_origin_pool.this]
  name                            = format("%s-lb", var.web_app_name)
  namespace                       = var.volterra_namespace
  description                     = format("HTTPS loadbalancer object for %s origin server", var.web_app_name)
  domains                         = var.app_domain
  advertise_on_public_default_vip = true
  default_route_pools {
    pool {
      name      = volterra_origin_pool.this.name
      namespace = var.volterra_namespace
    }
  }

  https_auto_cert {
    add_hsts      = var.enable_hsts
    http_redirect = var.enable_redirect
    no_mtls       = true
  }

  app_firewall {
    #name = "corp-waap-high-to-medium"
    #namespace = "shared"
    name = volterra_app_firewall.this.name
  }
  multi_lb_app      = false
  user_id_client_ip = true
  #source_ip_stickiness = true

  single_lb_app {
    enable_discovery {
      enable_learn_from_redirect_traffic = true
    }
    enable_ddos_detection           = true
    enable_malicious_user_detection = true
  }

  api_definitions {
    api_definitions {
      name      = format("%s-apidef", var.web_app_name)
      namespace = var.volterra_namespace
    }
  }

  active_service_policies {
    policies {
      name      = format("%s-api-sec-sp", var.web_app_name)
      namespace = var.volterra_namespace
    }
  }

}
