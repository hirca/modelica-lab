<!-- docs/01-introduction/index.md -->
---
layout: default
title: "Module 1: Introduction"
nav_order: 2
has_children: true
---

# Module 1: Introduction

## Introduction

[Module introduction content.]

## Learning Objectives

- Objective 1
- Objective 2

## Subtopics

{% assign subtopics = site.pages | where: "dir", page.dir | where_exp: "page", "page.name != 'index.md'" | sort: "nav_order" %}

{% for subtopic in subtopics %}
- [{{ subtopic.title }}]({{ subtopic.url | relative_url }})
{% endfor %}
