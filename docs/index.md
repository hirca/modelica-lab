---
layout: default
title: Modelica Lessons and Tutorials
---

# Modelica Lessons and Tutorials

Welcome to our comprehensive guide on Modelica. This site contains various modules and tutorials to help you master Modelica programming.

## Table of Contents

{% assign sorted_pages = site.pages | sort: "path" %}
{% for page in sorted_pages %}
  {% assign parts = page.path | split: "/" %}
  {% if parts.size == 3 and parts[0] == "docs" and parts[2] == "index.md" %}
    {% assign module_name = parts[1] | split: "-" | shift | join: " " | capitalize %}
### [{{ module_name }}]({{ site.baseurl }}{{ page.url }})
    {% for subpage in sorted_pages %}
      {% assign subparts = subpage.path | split: "/" %}
      {% if subparts.size == 3 and subparts[0] == "docs" and subparts[1] == parts[1] and subparts[2] != "index.md" %}
        {% assign topic_name = subparts[2] | split: "-" | shift | shift | join: " " | capitalize | remove: ".md" %}
- [{{ topic_name }}]({{ site.baseurl }}{{ subpage.url }})
      {% endif %}
    {% endfor %}
  {% endif %}
{% endfor %}

## Introduction

Here you can write a brief introduction to your Modelica lessons and tutorials.

## How to Use This Guide

Provide instructions on how to navigate through the modules and make the most of the tutorials.

## Resources

List any additional resources, references, or tools that might be helpful for learning Modelica.