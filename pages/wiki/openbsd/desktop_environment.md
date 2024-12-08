# Setting Up a Desktop Environment for OpenBSD

Initial setup for installing and configuring dwm as a desktop environment on OpenBSD. 

Everything posted here relies on my personal "Open Suck" project: [Open Suck](https://git.sr.ht/~bt/open-suck-installer)

## Show Don't Tell

<figure>
<img src="/public/images/open-suck-75.png" alt="Screenshot of OpenBSD 7.5 running dwm">
<figcaption>Open Suck: OpenBSD 7.5 running dwm on my X220</figcaption>
</figure>
 
## What You Get

The Open Suck installer gives you the absolute barebones desktop experience:

- `dwm` for window management
- `firefox` as your core web browser
- `aerc` for your terminal-based mail client
- `slock` for screen locking
- `scrot`/`slop` for simple screenshot utilities
- `dunst` for notifications

## Required Packages

Before we begin setting things up, you will need to install `git`, `vim`, `bash`:

    pkg_add git vim bash

## Cloning the Project

Clone the main installer project and navigate instead the directory:

    git clone https://git.sr.ht/~bt/open-suck-installer
    cd open-suck-installer

## Installing

1. Install dependencies by running `./install-dependencies.sh`. The script will simply read required packages from `dependencies.txt` and run `pkg_add`.
2. Compile and install suckless software by running the `./install.sh`

## TL;DR

    cd open-suck-installer # CD into this repository
    doas sh ./install-dependencies.sh # Install OpenBSD packages
    doas sh ./install.sh # Install suckless tools
    cp .xinitrc ~/.xinitrc # Apply .xinitrc

Reboot the machine. Log in as your main user. Run:


    startx


That's it! You now have a fully functional desktop environment built on top of `dwm`.
