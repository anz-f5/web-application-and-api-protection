variable "api_url" {
  type    = string
  default = "https://f5-apac-ent.console.ves.volterra.io/api"
}

variable "api_cert" {
  type    = string
  default = "./certificate.cert"
}

variable "api_key" {
  type    = string
  default = "./private.key"
}

variable "web_app_name" {
  type        = string
  default     = "cz-shop"
  description = "Web App Name. Also used as a prefix in names of related resources."
}

variable "volterra_namespace_exists" {
  type        = string
  description = "Flag to create or use existing volterra namespace"
  default     = true
}

variable "volterra_namespace" {
  type        = string
  default     = "chzhang"
  description = "F5XC app namespace where the object will be created. This cannot be system or shared ns."
}

variable "app_domain" {
  type        = list(any)
  description = "FQDN for the app."
  default     = ["shop.f5xc.meowmeowcode.io"]
}

variable "origin_server_dns_name" {
  type        = list(any)
  description = "Origin server's publicly resolvable dns name"
  default     = ["shop.foobz.com.au"]
}

variable "origin_server_sni" {
  type        = string
  description = "Origin server's SNI value"
  default     = "shop.foobz.com.au"
}

variable "enable_hsts" {
  type        = bool
  description = "Flag to enable hsts for HTTPS loadbalancer"
  default     = true
}

variable "enable_redirect" {
  type        = bool
  description = "Flag to enable http redirect to HTTPS loadbalancer"
  default     = true
}
