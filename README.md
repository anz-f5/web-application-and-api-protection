# Web Application and API Protection (WAAP) on F5 Distributed Clouds (F5XC) 

This repo aims to demonstrate how to use SaaS based WAAP via the F5XC platform.

The F5XC has its own set of Terraform providers ( https://docs.cloud.f5.com/docs/how-to/volterra-automation-tools/terraform#:~:text=The%20F5%C2%AE%20Distributed%20Cloud,Services%20objects%20in%20the%20backend. ). 

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
Currently a **volterra_api_definition** resource expects a value for swagger_specs, which is only available after you have uploaded the swagger file via GUI beforehand.





