<!-- docs/01-introduction/hello-world.md -->
---
layout: default
title: "Hello World in Modelica"
parent: "Module 1: Introduction"
nav_order: 1
---

# {{ page.title }}

## Introduction

In this subtopic, we'll create our first Modelica model: a simple "Hello World" example.

## Theory/Concepts

[Explain the concepts relevant to this subtopic.]

## Example

Here's how you can write a simple Modelica model:

```modelica
model HelloWorld
  annotation(
    experiment(StartTime=0, StopTime=1));
equation
  // No equations needed for this simple model
end HelloWorld;
