---
title: About
---
I'm a freelance software developer Berlin, Germany. I work on low-level software like operating systems (kernels and drivers alike) and firmware for embedded systems. My main interest is using strong type-safety to write software in resource-constrained and timing-sensitive applications with good performance with better robustness and correctness than with other approaches.

Even before my professional career I have been a long-term C++ enthusiast, having worked mostly on game console emulators. You can read more about my background on my [resume](/resources/resume.pdf).

## Portfolio

### [Dolphin, GameCube/Wii](https://dolphin-emu.org)

I fixed a lot of really cool [GPU emulation bugs](https://dolphin-emu.org/blog/2014/03/15/pixel-processing-problems), and eventually became the maintainer of the GPU emulator subsystem. I also revamped parts of the user interface for a more user-friendly experience, implemented Dolphin's (at the time very overdue) [hardware testing framework](https://github.com/dolphin-emu/hwtests), and managed the release of [two](https://forums.dolphin-emu.org/Thread-dolphin-3-0-release-announcement) [major](https://forums.dolphin-emu.org/Thread-red-notice-2-announcement-dolphin-3-5-release-announcement) emulator versions.

### [PPSSPP, PSP](https://ppsspp.org)

I implemented PPSSPP's [software renderer](https://github.com/hrydgard/ppsspp/commits/74eafcab1afaf6c291e22e8ed69d3cf607ea7e16/GPU/Software) as a reference backend. At a time where few games were rendering properly with the existing OpenGL renderer, the software renderer provided us with a useful tool to see what assumptions were breaking the other backend and consequently helped us understand what needs to be addressed next. This project also taught me a lot about algorithms used in 3D renderers and about their implementation in hardware.

### [Citra, 3DS](https://citra-emu.org)

I cofounded [Citra](https://github.com/citra-emu/citra), the first functional 3DS emulator, back in 2014. I designed the graphics [emulation core](https://github.com/citra-emu/citra/tree/master/src/video_core) and implemented the software renderer. To ensure correctness of the written code, I developed various debugging utilities and testing infrastructure. I also created [some](https://github.com/citra-emu/uncart) [tools](https://github.com/neobrain/braindump) for users to dump content from their 3DS and wrote introductory documentation to help people get started with citra development.
