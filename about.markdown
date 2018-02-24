---
title: About
---
Hi! My name is Tony - I'm a long-term C++ enthusiast, excited about writing low-level software without compromising on correctness, expressiveness, or performance. This website is where I'm gathering some of my thoughts on modern C++ and the projects I use it for. Occasionally, some rambling about Haskell may find its way to my blog, too :)

## Portfolio

I'm most well-known for my work on game console emulators.

### [Dolphin, GameCube/Wii](https://dolphin-emu.org)

I mainly worked on GPU emulation, having fixed a number of really [cool bugs](https://dolphin-emu.org/blog/2014/03/15/pixel-processing-problems) along the way. I also revamped parts of the user interface for a more user-friendly experience, and I implemented Dolphin's (at the time very overdue) [hardware testing framework](https://github.com/dolphin-emu/hwtests).

### [PPSSPP, PSP](https://ppsspp.org)

I implemented PPSSPP's [software renderer](https://github.com/hrydgard/ppsspp/tree/master/GPU/Software) as a reference backend. At a time where few games were rendering properly with the existing OpenGL renderer, the software renderer provided us with a useful tool to see what assumptions were breaking the other backend and consequently helped us understand what needs to be addressed next.

### [Citra, 3DS](https://citra-emu.org)

I cofounded [Citra](https://citra-emu.org), the first functional 3DS emulator, back in 2014. I designed the graphics emulation core and implemented the reference implementation for it. I also created [some](https://github.com/citra-emu/uncart) [tools](https://github.com/neobrain/braindump) for users to dump content from their 3DS and wrote introductory documentation to help people get started with citra development.

### Other projects

A long while ago, I've also worked on implementing the D3DX9 library in the [Wine](http://winehq.org) project.
