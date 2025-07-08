# Installing KDE Plasma on OpenBSD

2025-07-08

![alt text](/public/images/openbsd-kde-desktop.png)

~~~
doas pkg_add consolekit2 polkit-kde-agent kde_plasma kde_plasma_extras
~~~

After the install you should read over the very helpful documentation found in your `pkg-readmes` directory:

## Services and Permissions

Before doing anything else, your user should be added to both the `_shutdown` user group and the `kde` login class. This allows your user to perform power actions (shutdown, reboot etc.):

~~~
doas usermod -G _shutdown your-username
doas usermod -L kde your-username
~~~

Then we also need `messagebus` enabled and running in order to perform these shutdown, logout, and reboot functions:

~~~
doas rcctl service enable messagebus
doas rcctl service start messagebus
~~~

## Performance Improvements

In your `/etc/sysctl.conf` file:

~~~
kern.maxfiles=65535
~~~

## Configuring `startx`

Edit your `~/.xinitrc` file:

~~~
exec ck-launch-session startplasma-x11
~~~

## Working with 4K Resolutions

In your `~/.xsession` file:

~~~
export GDK_SCALE=1.25
export QT_SCALE_FACTOR=1.25
~~~

In your `~/.Xdefaults` file:

~~~
Xft.dpi: 163
Xcursor.theme: Adwaita
Xcursor.size: 48
~~~
