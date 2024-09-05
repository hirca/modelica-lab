---
layout: page
title: "Object-Oriented Modeling in Modelica"
author: hirca
date: 2024-09-05
---

# 3. Object-Oriented Modeling in Modelica

## Introduction

Object-Oriented Modeling (OOM) is a powerful paradigm in Modelica that allows for the creation of modular, reusable, and hierarchical models. This approach is particularly beneficial in automotive engineering, where complex systems can be broken down into manageable components. In this module, we'll explore the core concepts of OOM in Modelica and how they apply to automotive systems.

> **Note:** This module builds upon the basic Modelica concepts covered in earlier modules. If you're new to Modelica, it's recommended to review the fundamentals before proceeding.

## 3.1. Classes and Objects

### Overview

In Modelica, classes are the fundamental building blocks of models. They encapsulate data (variables) and behavior (equations) into reusable units. Objects are instances of these classes, representing specific components in a system.

### Example: Creating a Simple Wheel Class

Let's create a basic wheel class that could be used in various automotive models:

```modelica
model Wheel
  parameter Real radius = 0.3 "Wheel radius in meters";
  parameter Real mass = 15 "Wheel mass in kg";
  Real angularVelocity "Wheel angular velocity in rad/s";
  Real torque "Applied torque in Nm";
equation
  // Simple rotational dynamics
  mass * radius^2 * der(angularVelocity) = torque;
end Wheel;
```

In this example, we've defined a `Wheel` class with parameters for radius and mass, variables for angular velocity and torque, and a basic equation representing rotational dynamics.

### Using the Wheel Class

Now, let's create objects (instances) of our `Wheel` class:

```modelica
model Car
  Wheel frontLeft(radius=0.35, mass=18);
  Wheel frontRight(radius=0.35, mass=18);
  Wheel rearLeft(radius=0.35, mass=20);
  Wheel rearRight(radius=0.35, mass=20);
  // ... other car components and equations ...
end Car;
```

Here, we've created four wheel objects with slightly different parameters, demonstrating how classes can be reused to create multiple objects with varying properties.

> **Tip:** When designing classes, consider what parameters and variables might need to be customized for different instances. This approach enhances the reusability of your models.

## 3.2. Inheritance and Polymorphism

### Overview

Inheritance allows new classes to be based on existing ones, inheriting their properties and behavior. This concept is crucial for creating specialized components while maintaining a common structure. Polymorphism enables the use of a single interface for different underlying forms.

### Example: Specialized Wheel Types

Let's extend our `Wheel` class to create specialized types:

```modelica
model Wheel
  // ... base Wheel model as before ...
end Wheel;

model SteeredWheel
  extends Wheel;
  Real steeringAngle "Steering angle in radians";
equation
  // Additional equations for steering dynamics
  der(steeringAngle) = steeringRate;
  // ... more equations ...
end SteeredWheel;

model PoweredWheel
  extends Wheel;
  Real engineTorque "Engine torque applied to the wheel";
equation
  // Override the base torque equation
  torque = engineTorque - brakeTorque;
  // ... additional equations for power transmission ...
end PoweredWheel;
```

In this example, we've created two specialized wheel types: `SteeredWheel` for front wheels that can be steered, and `PoweredWheel` for wheels that receive engine power.

### Using Inheritance in a Car Model

Now, let's use these specialized wheel types in a more detailed car model:

```modelica
model DetailedCar
  SteeredWheel frontLeft(radius=0.35, mass=18);
  SteeredWheel frontRight(radius=0.35, mass=18);
  PoweredWheel rearLeft(radius=0.35, mass=20);
  PoweredWheel rearRight(radius=0.35, mass=20);
  // ... other car components and equations ...
equation
  // Connect steering system to front wheels
  frontLeft.steeringAngle = steeringSystem.leftAngle;
  frontRight.steeringAngle = steeringSystem.rightAngle;
  
  // Connect engine to rear wheels
  rearLeft.engineTorque = engine.leftTorque;
  rearRight.engineTorque = engine.rightTorque;
  // ... more equations ...
end DetailedCar;
```

This example demonstrates how inheritance allows us to create a more sophisticated car model with specialized components, while still maintaining a clear and organized structure.

> **Important:** When using inheritance, carefully consider the implications on model behavior. Overridden equations or added components can significantly change the dynamics of the model.

## 3.3. Composition and Aggregation

### Overview

Composition and aggregation are techniques for building complex models by combining simpler ones. In Modelica, this is often achieved by declaring instances of other models as components within a larger model.

### Example: Building a Complete Vehicle Model

Let's create a more comprehensive vehicle model using composition:

```modelica
model Engine
  // ... engine model details ...
end Engine;

model Transmission
  // ... transmission model details ...
end Transmission;

model Chassis
  // ... chassis model details ...
end Chassis;

model Suspension
  // ... suspension model details ...
end Suspension;

model CompleteVehicle
  Engine engine;
  Transmission transmission;
  Chassis chassis;
  Suspension frontSuspension;
  Suspension rearSuspension;
  SteeredWheel frontLeftWheel;
  SteeredWheel frontRightWheel;
  PoweredWheel rearLeftWheel;
  PoweredWheel rearRightWheel;
equation
  // Connect components
  connect(engine.output, transmission.input);
  connect(transmission.output, rearLeftWheel.engineTorque);
  connect(transmission.output, rearRightWheel.engineTorque);
  // ... more connections and equations ...
end CompleteVehicle;
```

This example shows how we can compose a complex vehicle model from simpler component models. Each component (Engine, Transmission, etc.) can be developed and tested independently, then integrated into the larger system.

> **Tip:** When using composition, pay close attention to the interfaces between components. Clear and well-defined interfaces make it easier to swap out components or reuse them in different contexts.

## 3.4. Packages and Libraries

### Overview

Packages in Modelica are used to organize related models, functions, and other elements into a hierarchical structure. Libraries are collections of packages that provide reusable components for specific domains or applications.

### Example: Creating a Vehicle Components Package

Let's organize our vehicle components into a package:

```modelica
package VehicleComponents
  model Wheel
    // ... Wheel model as before ...
  end Wheel;
  
  model SteeredWheel
    // ... SteeredWheel model as before ...
  end SteeredWheel;
  
  model PoweredWheel
    // ... PoweredWheel model as before ...
  end PoweredWheel;
  
  model Engine
    // ... Engine model ...
  end Engine;
  
  model Transmission
    // ... Transmission model ...
  end Transmission;
  
  // ... other component models ...
end VehicleComponents;
```

### Using the Package in a Model

Now we can use this package to create our vehicle model:

```modelica
model VehicleModel
  import VC = VehicleComponents;
  
  VC.Engine engine;
  VC.Transmission transmission;
  VC.SteeredWheel frontLeftWheel;
  VC.SteeredWheel frontRightWheel;
  VC.PoweredWheel rearLeftWheel;
  VC.PoweredWheel rearRightWheel;
  // ... other components ...
equation
  // ... model equations ...
end VehicleModel;
```

This approach provides a clean and organized structure for our models, making it easier to manage complex systems.

> **Note:** Many standard Modelica libraries, such as the Modelica Standard Library (MSL), use this package structure. Familiarizing yourself with these libraries can greatly enhance your modeling capabilities.

## Summary

In this module, we've explored the key concepts of Object-Oriented Modeling in Modelica:

1. Classes and Objects: The basic building blocks for creating reusable model components.
2. Inheritance and Polymorphism: Techniques for extending and specializing models.
3. Composition and Aggregation: Methods for building complex models from simpler components.
4. Packages and Libraries: Organizational structures for managing and reusing model components.

These concepts provide powerful tools for creating modular, flexible, and maintainable models, particularly in the context of automotive engineering.

## Further Reading

- Fritzson, P. (2015). Principles of Object-Oriented Modeling and Simulation with Modelica 3.3: A Cyber-Physical Approach. Wiley-IEEE Press.
- Tiller, M. (2019). Modelica by Example. [Online] Available at: https://mbe.modelica.university/
- Modelica Association. (2021). Modelica Language Specification Version 3.5. [Online] Available at: https://specification.modelica.org/

In the next module, we'll explore more advanced topics in Modelica modeling, building on the object-oriented concepts we've covered here.
