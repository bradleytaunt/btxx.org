# OpenBSD is a Cozy Operating System

2024-04-11

![Screenshot of OpenBSD 7.5 running dwm](/public/images/open-suck-75.webp)

*OpenBSD 7.5 running dwm on my X220*

With the recent release of OpenBSD 7.5, I decided to run through my [personal OpenBSD "installer"](https://git.btxx.org/open-suck/about/) for laptop/desktop devices. The project is built off of the `dwm` tiling window manager and only installs a few basic packages. The last time I updated it was with the release of 7.3, so it's been due for an minor rework.

While making these minor changes, I remembered how incredibly easy the entire install process for OpenBSD is and how *cozy* the entire operating system feels. All the core systems just work out the box. Yes, you need to "patch" in WiFi with a firmware update, so you'll need an Ethernet connection during the initial setup. Yes, the default desktop environment is not intuitive or ideal for newcomers.

But the positives heavily outweigh the negatives (in my opinion):

- Incredibly secure operating system (No `xz` drama here...)
- Detailed documentation. Probably one of the best of any OS
- Much smaller codebase and small core team
- *Complete* operating system (kernel, userland utilities, libraries, applications combined)

These points might not seem important to others, but they are to me. Maybe you're possibly interested in checking it out yourself? If you are, then read on...

## Try it Yourself!

I've tried my best to write up a simplified, noob-friendly guide on both setting up the core OpenBSD system, along with installing a simple `dwm` based desktop environment. These are both focused on personal devices (laptops/computers), so if you're looking for server-specific setups you won't find that here!

You can find both of those wiki-pages below:

- [Installing OpenBSD](https://btxx.org/wiki/openbsd/installation/)
- [Setting up a Desktop Environment for OpenBSD](https://btxx.org/wiki/openbsd/desktop_environment/)

Some additional reading I highly recommend is: [c0ffee.net/blog/openbsd-on-a-laptop](https://www.c0ffee.net/blog/openbsd-on-a-laptop)
