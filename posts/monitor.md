# Why I Stopped Using an External Monitor

2023-03-03

For the longest time I've been using a Samsung 27" UHD monitor as my main display. This monitor was connected to my ThinkPad X260 (in clamshell mode) through the official Lenovo dock. It wasn't a bad setup, but I have since changed my ways.

Instead, I now *only* use the X260's panel as my main display. Let me explain my reasoning...

## The Switch to Suckless

Over the past year I switched away from a traditional desktop environment to a window manager - [dwm](https://dwm.suckless.org/) to be specific. This also involved changing most of my daily software programs to utilize the full suckless "suite". In doing so, the shift away from floating windows and virtualized desktops happened quickly.

I continued to use my UHD monitor with this new environment but slowly started running into minor (yet still inconvenient) roadblocks:

- Tiled mode was not the most optimized for such a large monitor. I found myself defaulting into "floating" mode which defeats the purpose of a WM.
- The screen was almost *too* large - making content placed on the far edges of the screen difficult to view at a glance.
- I stopped using tags, since I ended up piling applications on top of one another in a single view. Again - defeating the point of a WM.

All of these issues were close to making me ditch the external monitor altogether, but it was my day-to-day job that struck the final blow...

## Designing for Everyday Users

As a UX/UI front-end designer by trade, my job requires me to create and tweak interfaces that essentially go *unnoticed* by the end-users. If you finish a task you sought out to complete without even thinking about *how* you did it - then I succeeded at my job. The problem is, we designers and developers tend to forget the constraints a majority of our users experience. In this case - screen resolution.

[A study performed by BrowserStack via statcounter (2022)](https://www.browserstack.com/guide/ideal-screen-sizes-for-responsive-design) shows the worldwide market share based on device type:

- 58.33% mobile
- 39.65% desktop
- 2.02% tablet

The mobile aspect is certainly important, but we are focusing on the desktop data. Of that total the top two screen resolutions are:

- 1920×1080 (9.94%)
- 1366×768 (6.22%)

That is a fairly significant chunk of desktop users. Although almost 10% have access to screens set at `1920x1080`, I found the amount of those stuck at `1366x768` to be quite shocking. Here I was, developing large-set interfaces on an UHD 4K monitor while a large portion of my end-users would never benefit from those "pixel-perfect" designs. 

Hell, some of these users were being shown the *tablet*-based view of the applications since our breakpoints were so ridiculously large. Yikes.

So, I said screw it and retired the external monitor. Now my X260 is propped up and proudly showing off its 1366x768 display. It only took a day or so to adapt to this new setup and I don't think I could go back to another massive display.

Here are some benefits at a glance:

- I no longer have to worry about "context switching" if I decide to un-dock my laptop and work somewhere mobile. The desktop experience remains intact.
- Working inside `dwm` is a much cleaner experience. I mostly operate single applications within their own confined tag - with some exceptions of course.
- I'm able to instantly understand frustrations of everyday users while developing new features or tweaking existing UIs. Being able to advocate for our end-users by using legit use cases is extremely helpful. (Removes the "design by gut-feeling" mistakes)

<figure>
    <img src="/public/images/dither-desktop.webp" alt="My current desktop setup with the X260 ThinkPad">
    <figcaption>My ThinkPad X260, along with my MageGee wired mechanical keyboard and Logitech Pebble mouse. Small notebook and pen for note-taking.</figcaption>
</figure>

## A Little Extreme

Yes, I am aware that I could simply keep the UHD monitor and perform my work within a constrained portion of the screen. The problem that remains is "quality". Most 1366x768 panels are not even close to the level of hi-res found on most 4K monitors. By using such a display I would be cheating myself of the standard experience a good portion of my end-users endure. 

I want to see the fuzzy text, slightly blurred imagery and muted button shadows. I want to see these things because that's how some *users* will experience it.

Maybe that's extreme - but it works for me.