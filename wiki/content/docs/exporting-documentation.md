---
date: 9.11.2021
title: Exporting documentation
weight: 22
---
# Exporting documentation

{{< vimeo id="617181825" title="gRPC Documentation on TYK with GenDocu" >}}

You can export the GenDocu documentation and embed it within your existing CMS system. 
We generate the HTML code snippet for every project. You can find it in the `Integrations` tab in your project. 

## Setting the CORS

Before embedding the widget, you have to set the CORS.
It is the security mechanism to prevent embedding your project on some unauthorized webpage. 
Add your domain to the `Domain Restriction` list - you can use wildcard `*` to add multiple subdomains at once.

## Protecting the embedded documentation

GenDocu does not support OAuth login in the widget mode. The only way to access the private documentation via widget is to create a password. 
You can have an arbitrary number of passwords.


# Building own GenDocu widget

We will open-source the react documentation soon - it would be easy to copy, self-host, and adjust it to your needs.
