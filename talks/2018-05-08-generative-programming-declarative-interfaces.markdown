---
title: "Generative Programming & Declarative Interfaces:<br>Emulating the Nintendo 3DS"
url: https://skillsmatter.com/skillscasts/11505-generative-programming-in-action-emulating-the-3ds
location: "C++::Now"
---

Console emulation needs to stem the difficult balance between optimizing code for stable frame rates and maintaining the complex logic required to emulate the given hardware - any subtle bug in this system easily manifests in a user-visible glitch. How can modern C++ help?

Using the toolbox of generative programming, we take a look at the interprocess communication subsystem of the 3DS and see how far variadic templates, function reflection, and some metaprogramming will get us in terms of bridging the gap between performance, maintainability, and correctness.

Based on this example I will introduce the general idea of generators and declarative interfaces, and how we can use them in serialization-like problems to provide reusable and customizable functionality with a uniform API that minimizes boilerplate code.
