---
title: "Generative Programming in Action: Emulating the 3DS"
video: https://skillsmatter.com/skillscasts/11505-generative-programming-in-action-emulating-the-3ds
location: "C++::London"
slides: "/talks/cpplondon_feb2018/"
---

Console emulation needs to stem the difficult balance between optimizing code for stable frame rates and maintaining the complex logic required to emulate the given hardware - any subtle bug in this system easily manifests in a user-visible glitch. How can modern C++ help?

Using the toolbox of generative programming, we take a look at the system call interface of the 3DS and see how far variadic templates, function reflection, and some metaprogramming will get us in terms of bridging the gap between performance, maintainability, and correctness.

This is a beginner-friendly talk - prior knowledge of metaprogramming is not required!
