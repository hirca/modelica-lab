---
layout: default
title: Hello World in Modelica
---

# Hello World in Modelica

In this lesson, we'll create our first Modelica model: a simple "Hello, World!" program.

## The Code

Here's a basic "Hello, World!" model in Modelica:

```modelica
model HelloWorld
  annotation(experiment(StopTime = 0));
initial equation
  Modelica.Utilities.Streams.print("Hello, World!");
end HelloWorld;
```

## Explanation

Let's break down this code:

1. `model HelloWorld`: This declares a new model named HelloWorld.
2. `annotation(experiment(StopTime = 0))`: This tells the simulator to stop immediately, as we don't need any simulation time for this example.
3. `initial equation`: This section is executed at the start of the simulation.
4. `Modelica.Utilities.Streams.print("Hello, World!")`: This line prints our message.
5. `end HelloWorld`: This closes our model definition.

## Running the Model

To run this model:

1. Save it in a file named `HelloWorld.mo`
2. Open it in your Modelica simulation environment (like OpenModelica or Dymola)
3. Compile and run the model

You should see "Hello, World!" printed in the simulation output.

## Next Steps

Now that you've created your first Modelica model, let's move on to learning about basic syntax and structure in Modelica.