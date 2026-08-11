# Adventures in Creating a Minimal Alpine Linux Installer

2022-12-08

## Introduction

I've made the switch to Alpine Linux as my main laptop/desktop hybrid
workstation and I love it - warts and all. This post will follow my process building my Alpine Linux "installer" I used for this workstation, along with covering some bugs I found during my adventure.

My main goals when starting this project were to have a daily driver that was:

- free of any "real" desktop environment
- Wayland based with SwayWM
- as lightweight as possible

Overall, I think I achieved what I was aiming for. After logging in (there is no login manager, you do it directly through the boot terminal) you will see:

![](/public/images/alpine-1.webp)

(You can view the [full res image here](/public/images/alpine-1.webp))

For reference this is running on a X260 ThinkPad with 16GB RAM, docked and connected to a 27" 4K monitor.

> If you'd prefer to just go straight to the installer, feel free to jump over to the project repo: [https://git.sr.ht/~bt/alpine-linux-setup](https://git.sr.ht/~bt/alpine-linux-setup)

## Getting Started

My main reasoning for switching away from my previous setup (Garuda Linux running Sway) to Alpine was two fold:

1. I wanted a more lightweight, less resource hungry system
2. I wanted to go as "full" Wayland as possible

### Benchmarks Comparisons

I should mention that these are not official "benchmark" applications or proper testing. I merely reproduced the same tasks, using the same applications, for the same amount of time and compared the usage. Just keep that in mind!

- **Garuda Linux**
  - SwayWM
  - Firefox: 9 tabs (Figma included)
  - qutebrowser: 7 tabs
  - aerc: open/running
  - tut: open-running
  - Sublime Text: single project open
  - **Memory usage (range): 6.0-7.2 GB**

- **Alpine Linux**
  - SwayWM
  - Firefox: 9 tabs (Figma included)
  - qutebrowser: 7 tabs
  - aerc: open/running
  - tut: open-running
  - **Memory usage (range): 1.0-3.5 GB**

Switching over has basically cut my system memory usage **in half**. That ended up being a much better improvement than I predicted. These are beyond just numbers too - the system *feels* snappier.

So, from a speed and usability stand point I considered this a success already.

## Crashes &amp; Roadblocks

Of course, things didn't run 100% flawlessly out-of-the-box. There were some pretty annoying **crashes** and issues.

### Greetings, tty

After installing `tut` I started walking through its guided setup. Once it prompted me to login via browser in order to authenticate, I clicked the link provided in the terminal. I was immediately thrown out of my session and into `tty`. Awesome.

I'll save you both the headache and large amount of time I wasted on this silly "bug" and just say it had to do with my user settings trying to launch "Chromium" as my default browser. I normally set qutebrowser as much default, so this was a change I needed to make anyway.

I put the following in my `/etc/xdg/mimeapps.list` (which is included by default with the installer)

~~~sh
[Default Applications]
x-scheme-handler/http=org.qutebrowser.qutebrowser.desktop
x-scheme-handler/https=org.qutebrowser.qutebrowser.desktop
x-scheme-handler/ftp=org.qutebrowser.qutebrowser.desktop
x-scheme-handler/chrome=org.qutebrowser.qutebrowser.desktop
text/html=org.qutebrowser.qutebrowser.desktop
application/x-extension-htm=org.qutebrowser.qutebrowser.desktop
application/x-extension-html=org.qutebrowser.qutebrowser.desktop
application/x-extension-shtml=org.qutebrowser.qutebrowser.desktop
application/xhtml+xml=org.qutebrowser.qutebrowser.desktop
application/x-extension-xhtml=org.qutebrowser.qutebrowser.desktop
application/x-extension-xht=org.qutebrowser.qutebrowser.desktop
image/bmp=feh.desktop
image/gif=feh.desktop
image/jpeg=feh.desktop
image/jpg=feh.desktop
image/png=feh.desktop
image/tiff=feh.desktop
image/x-bmp=feh.desktop
image/x-pcx=feh.desktop
image/x-tga=feh.desktop
image/x-portable-pixmap=feh.desktop
image/x-portable-bitmap=feh.desktop
image/x-targa=feh.desktop
image/x-portable-greymap=feh.desktop
application/pcx=feh.desktop
image/svg+xml=feh.desktop
image/svg-xml=feh.desktop
~~~

You might have also noticed that I use `feh` as my default image viewer as well. That's just my personal preference, feel free to switch that out as you see fit.

**Sidenote:** Chromium now runs perfectly fine since the original crashes. I have no clue how or why. Wayland black magic, I assume? Maybe I installed a package that helped or an update occurred. *Shrug*

### Screen Sharing

This has been a complete failure for me. I've tried both the Chromium and Firefox [implementations of these "hacks"](https://lr.vern.cc/r/swaywm/comments/l4e55v/guide_how_to_screenshare_from_chromiumfirefox/) but neither work. For now I will fallback to my Garuda Linux OS boot and share my screen there. It's a silly workaround but I hardly ever need to "show my screen" in any capacity as is.

I can live without this for now. (Please [leave a message in my personal inbox](https://lists.sr.ht/~bt/public-inbox) if you know of another workaround for this!)

## Some Minor Tweaks

Some of these "hacks" or tweaks I had to implement might help others who run into similar issues when setting up their own Alpine desktops.

### aerc-mail

It is important to install `gawk` since `awk` isn't "real" on Alpine. Once you have that on you system `aerc` will render emails out-of-the-box.[^1]

~~~sh
apk add gawk
~~~

### Sublime Text

Sublime Text requires flatpak, so if that isn't your *thing* then you're better off snagging a different editor. I've tried multiple times throughout my career to use an alternate editor (preferably 100% open source) but keep finding myself returning to Sublime. Maybe one day...

~~~sh
apk add flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
~~~


Then reboot your machine for the changes to take. Login again and run:

~~~sh
flatpak install flathub com.sublimetext.three
~~~

FYI: You *might* need to run the above commands under `sudo` if your current user lacks proper permissions.


### Cursors

This was an odd edge case. For the most part, the default system cursors worked out of the box. Then I installed Firefox. That caused me to go down a rabbit-hole of (still open) tickets referencing poor cursor rendering for Wayland Firefox. Apparently some users even have their cursors disappear completely!

Not to worry though - there is an easy fix!

1. Install [capitaine cursors](https://github.com/keeferrourke/capitaine-cursors): `apk add capitaine-cursors`
2. Make a new directory: `mkdir -p ~/.icons/capitaine-cursors`
3. Copy the files over: `sudo cp -r /usr/share/icons/capitaine-cursors-dark ~/.icons/capitaine-cursors`
4. The make your cursor changes using `gnome-tweaks`
5. Profit!

## Closing Thoughts

Overall I'm decently satisfied with my "installer". I've included *just enough* packages to hit the ground running when using this on new hardware or even needing to recover existing devices. This project certainly won't cover the needs of all users, but my hope is that others can always fork their own and give it a spin! (Please do report any bugs or issues as you come across them!)

Alpine Linux can be more than just a "server distro". My daily driver proves it!

[^1]: This is now included in my official installer script, but I originally had to install this manually.
