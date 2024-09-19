<!-- docs/index.md -->
---
layout: default
title: "Home"
nav_order: 1
---

# {{ site.title }}

Welcome to the Modelica Lab curriculum! Below is the list of modules:

{% assign modules = site.pages | where_exp: 'page', "page.path contains '/docs/' and page.path != '/docs/index.md' and page.name == 'index.md'" | sort: 'nav_order' %}

{% for module in modules %}
- [{{ module.title }}]({{ module.url | relative_url }})
{% endfor %}
