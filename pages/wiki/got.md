# got (Game of Trees)

This page contains a comprehensive guide to setting up `got` and `gotwebd` on an OpenBSD server through `httpd` and `haproxy`.

For reference, you can see a **live version** [here](https://got.btxx.org).

The following assumes you have already setup an active `git` server on your OpenBSD instance.

## Installing `got`

Since `got` is a first-class citizen on OpenBSD, installation is very easy:

~~~sh
pkg_add got gotwebd
~~~

* `/var/www/got/public/`: Default location for Git repositories served by gotwebd
* `/var/www/htdocs/gotwebd/`: Directory containing HTML, CSS, and image files used by gotwebd.
* `/var/www/run/gotweb.sock`: Default location for the gotwebd listening socket.

Read more on the [official man pages](https://gameoftrees.org/gotwebd.8.html)

## Configuration

Include the following to your existing `/etc/httpd.conf` file. Be sure to change the domain and directory location to match your own.

~~~sh
types { include "/usr/share/misc/mime.types" }

server "got.btxx.org" {
    listen on 127.0.0.1 port 8080
    root "/htdocs/gotwebd"
    location "/" {
        fastcgi socket "/run/gotweb.sock"
    }
}
~~~

Next create (or edit if it already exists) the main `/etc/gotwebd.conf` file:

~~~sh
server "localhost" {
    repos_path "/got/public"
    site_name "btxx projects"
    site_owner "Bradley Taunt"
    site_link "got.btxx.org"
}
~~~

**Important**: You will also need to fix permissions to avoid warnings:

~~~sh
doas mkdir -p /var/www/got/tmp
doas chown www:daemon /var/www/got/tmp
~~~

You may also be required to give user `www` access to the main `htdocs/gotwebd` directory:

~~~sh
doas chown www:www /var/www/htdocs/gotwebd`
~~~

## Running Our Services

Now we simply run and enable all our required services:

~~~sh
doas rcctl enable httpd slowcgi gotwebd
doas rcctl start httpd slowcgi gotwebd
~~~

**And you should be good to go!**
