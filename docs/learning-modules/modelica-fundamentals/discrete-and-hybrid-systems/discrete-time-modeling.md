---
layout: page
title: "5.1 Discrete-time modeling"
author: hirca
date: 2024-09-10
category: Modelica
tags: [modelica, automotive, discrete systems, sampling]
---

# 5.1 Discrete-time modeling

## Introduction

Discrete-time modeling is an essential aspect of automotive systems, particularly in digital control systems and signal processing. In this section, we'll explore how Modelica handles discrete-time systems and their applications in automotive engineering.

## Key Concepts

### Sampling and Hold

In discrete-time systems, continuous signals are sampled at specific time intervals. This process is crucial in digital control systems, where analog signals are converted to digital form for processing.

### Discrete-time Variables

Modelica uses the `discrete` keyword to declare variables that change only at discrete time instants.

### Sample Operator

The `sample()` operator in Modelica is used to create discrete-time signals from continuous-time signals.

## Modelica Implementation

Let's look at a simple example of discrete-time modeling in Modelica:

```modelica
model DiscretePI
  parameter Real Kp = 1 "Proportional gain";
  parameter Real Ti = 1 "Integral time constant";
  parameter Real Ts = 0.1 "Sampling time";
  
  input Real u "Input signal";
  output Real y "Output signal";
  
  discrete Real x "Integral state";
  discrete Real e "Error signal";

equation
  when sample(0, Ts) then
    e = u - pre(y);
    x = pre(x) + Ts/Ti * e;
    y = Kp * (e + x);
  end when;
end DiscretePI;
```

This model represents a discrete-time PI (Proportional-Integral) controller, commonly used in control systems.

### Explanation

1. We declare discrete variables `x` and `e` using the `discrete` keyword.
2. The `when` clause is triggered every `Ts` seconds, starting at time 0.
3. `pre()` is used to access the previous value of a variable.
4. The controller calculates the error, updates the integral state, and computes the output at each sample time.

## Example: Engine Speed Control

Let's consider a simplified engine speed control system using discrete PI controller:

```modelica
model DiscreteEngineSpeedControl
  discrete Real setpoint(start=3000) "Desired engine speed (rpm)";
  discrete Real actual_speed(start=1000) "Actual engine speed (rpm)";
  discrete Real error "Control error";
  discrete Real integral "Integral of error";
  discrete Real control_output "Controller output";
  
  parameter Real Kp = 2.0 "Proportional gain";
  parameter Real Ki = 0.5 "Integral gain";
  parameter Real T = 0.2 "Engine time constant";
  parameter Real Ts = 0.1 "Sampling time (increased for visibility)";

equation
  // Update setpoint at specific time
  when time >= 1 then
    setpoint = 5000;
  end when;

  // Discrete-time PI controller
  when sample(0, Ts) then
    error = setpoint - pre(actual_speed);
    integral = pre(integral) + error*Ts;
    control_output = Kp * error + Ki * integral;
    actual_speed = pre(actual_speed) + (control_output - pre(actual_speed)) * Ts / T;
  end when;

  // For debugging
  when terminal() then
    Modelica.Utilities.Streams.print("Final setpoint: " + String(setpoint));
    Modelica.Utilities.Streams.print("Final actual speed: " + String(actual_speed));
  end when;
end DiscreteEngineSpeedControl;
```

## Summary

Discrete-time modeling in Modelica allows us to accurately represent digital control systems and sampled-data processes common in automotive applications. By using the `discrete` keyword, `sample()` operator, and `when` clauses, we can create models that combine continuous and discrete-time elements, crucial for modern automotive control systems.

## Further Reading

1. Fritzson, P. (2015). Principles of Object-Oriented Modeling and Simulation with Modelica 3.3: A Cyber-Physical Approach. Wiley-IEEE Press.
2. Tiller, M. (2019). Modelica by Example. [https://mbe.modelica.university/](https://mbe.modelica.university/)

