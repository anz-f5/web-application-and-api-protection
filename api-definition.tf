# API Definition for API Protection
resource "volterra_api_definition" "myshop-apidef" {
  name      = format("%s-apidef", var.web_app_name)
  namespace = var.volterra_namespace

  swagger_specs = ["https://f5-apac-ent.console.ves.volterra.io/api/object_store/namespaces/chzhang/stored_objects/swagger/cz-hackazon-swagger/v1-22-04-04"]
}
