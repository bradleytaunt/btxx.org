# Desktop Improvements for OpenBSD

If you're using a 4K monitor, you may want to scale things properly. Add the
following to the top of the `~/.xinitrc` file:

~~~
export GDK_SCALE=1.5
export QT_SCALE_FACTOR=1.5
~~~

Then include the following to the existing `~/.Xdefaults` file:

~~~
Xft.dpi: 144
Xcursor.theme: Adwaita
Xcursor.size: 34
~~~

More to come...
