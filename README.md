# Web Application and API Protection (WAAP) on F5 Distributed Clouds (F5XC) 

## Overview
This repo aims to demonstrate how to use SaaS based WAAP via the F5XC platform.

The F5XC has its own set of Terraform providers ( https://docs.cloud.f5.com/docs/how-to/volterra-automation-tools/terraform ). 

This repo uses the provider to create the followings,

 - a HTTP load balancer
 - an origin pool
 - a monitor
 - an app firewall
 - a security policy

The app firewall provides signature based protection to all traffic.

For API protection, it is accomplished via a service policy and its associated custom rule list. 

The rule list contains individual rules that apply an action (Allow/Deny) based upon the group name of an API. The group name of an API is defined withint an API definition swagger file (i.e., shopazone-swagger.json).

Inside of this swagger file, individual API's are put into assigned groups via tags. In the below example, after this swagger file is imported , the group name 'ves-io-api-def-myshop-apidef-read' is referenced in an individual rule.

```python
...
"x-volterra-api-group": "read",
...
```
Currently a **volterra_api_definition** resource (within api-definition.tf) expects a value for swagger_specs, which is only available after you have uploaded the swagger file via GUI beforehand.

## Notes

The Terraform provider expects the following for API access to F5XC

```python
provider "volterra" {
  api_cert = var.api_cert
  api_key  = var.api_key
  url      = var.api_url
}
```
This menas you need to create a credential within F5XC portal in the form of an API certificate. 

The certificate comes as a .p12 file and you can extra the cert and key and save them into two seperate files as follows.

```python
openssl pkcs12 -info -in f5-apac-ent.console.ves.volterra.io.api-creds.p12 -nokeys -out certificate.cert 

openssl pkcs12 -info -in f5-apac-ent.console.ves.volterra.io.api-creds.p12 -nodes -nocerts -out private.key 
```








