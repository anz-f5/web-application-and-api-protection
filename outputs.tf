output "WAAP_URL_for_protected_application" {
  description = "WAAP URL for protected appliation"
  value       = format("https://%s", var.app_domain[0])
}
