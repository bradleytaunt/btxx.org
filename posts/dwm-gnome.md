# Bringing dwm Shortcuts to GNOME

2023-11-02

The `dwm` window manager is my standard "go-to" for most of my personal laptop environments. For desktops with larger, higher resolution monitors I tend to lean towards using GNOME. The GNOME DE is fairly solid for my own purposes. This article isn't going to deep dive into GNOME itself, but instead highlight some minor configuration changes I make to mimic a few `dwm` shortcuts.

For reference, I'm running GNOME 45.0 on Ubuntu 23.10

## Setting Up Fixed Workspaces

When I use `dwm` I tend to have a hard-set amount of `tags` to cycle through (normally 4-5). Unfortunately, dynamic rendering is the default for workspaces (ie. tags) in GNOME. For my personal preference I set this setting to `fixed`. We can achieve this by opening **Settings** >  **Multitasking** and selecting "Fixed number of workspaces".

![Screenshot of GNOME's Multitasking Settings GUI](/public/images/gnome-1.webp)

## Setting Our Keybindings

Now all that is left is to mimic `dwm` keyboard shortcuts, in this case: `ALT` + `$num` for switching between workspaces and `ALT` + `SHIFT` + `$num` for moving windows across workspaces. These keyboard shortcuts can be altered under **Settings** &rarr; **Keyboard** &rarr; **View and Customize Shortcuts** &rarr; **Navigation**.

You'll want to make edits to both the "Switch to workspace *n*" and "Move window to workspace *n*". 

![Screenshot of GNOME's keyboard shortcut GUI](/public/images/gnome-2.webp)

![Screenshot of GNOME's keyboard shortcut GUI](/public/images/gnome-3.webp)

That's it. You're free to include even more custom keyboard shortcuts (open web browser, lock screen, hibernate, etc.) but this is a solid starting point. Enjoy tweaking GNOME!

