# Installing GNOME on OpenBSD 7.8

2025-11-07

This post is just a quick guide to get your OpenBSD desktop or laptop up-and-running with the GNOME desktop environment quickly. You can take things further once everything is setup, but I'll be keeping things basic for now.

* toc
{:toc}

After following all my install and configuration steps, your desktop can look something like this:

![OpenBSD Gnome desktop](/public/images/openbsd-gnome-desktop.webp)

## GNOME Packages

Before we can do anything, we will need the required packages. Run the following as `root` (or use `doas` if you prefer):

~~~sh
pkg_add gnome gnome-extras
~~~

The final output will reference reading some of the newly installed packages' manuals. The main two you should focus on are:

~~~sh
cat /usr/local/share/doc/pkg-readmes/gnome
cat /usr/local/share/doc/pkg-readmes/upower
~~~

You should always check the man pages directly since they can change over time but at the time of writing, you need to run the following after your install:

~~~sh
rcctl disable xenodm
rcctl enable multicast messagebus avahi_daemon gdm apmd
reboot
~~~

That's honestly it! Once it reboots you'll be greeted with the graphical login (`gdm`). Enjoy GNOME of your OpenBSD device!

Below I have some extra, optional steps to help further configure your system. 

## Quirks and Tweaks

### 4K Screens

Since I use a 4K monitor with my main mini PC, text and window UI can look pretty small with the default settings in GNOME. After the initial boot into the system, I make changes under **Settings** -> **Displays** and set the scale to 200%. It should change automatically, but in some instances a reboot will be required.

<figure>
<img src="/public/images/openbsd-gnome-settings.png" alt="GNOME Displays Settings pane">
<figcaption>GNOME Displays setting set to 200%</figcaption>
</figure>

### GNOME Extensions

In order to install custom extensions for GNOME, you first need to install `chromium` and set proper permissions within the browser's `unveil.main` file.

~~~sh
doas pkg_add chromium
~~~

After the install completes, open your terminal (or editor of choice) and append the following to `/etc/chromium/unveli.main`:

~~~sh
# Gnome shell extensions
/usr/local/bin r
/usr/local/bin/gnome-browser-connector-host rx
~~~

Now launch the Chromium browser and navigate to [Gnome Shell Extensions](https://extensions.gnome.org/). Click the "install browser extension" and follow the prompts. After installing the browser extension, feel free to download any GNOME plugin you wish. The first extension I always grab is [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/), which will allow you to customize your main dock similar to mine shown in the first image of this article.

You can configure the details of each installed extension by using the built-in Extensions program that ships with GNOME.

## The Future of GNOME

As much as I enjoy using GNOME, the future of the project doesn't look promising on OpenBSD. The core GNOME developers are dropping Xorg support in the upcoming releases - which is a real shame since I don't think Wayland is even *remotely* close to replacing all programs dependent on existing X11 infrastructure. Having software options in the FOSS community should be the standard!

Maybe I'll switch on over to MATE? Who knows!
