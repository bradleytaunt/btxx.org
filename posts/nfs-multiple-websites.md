# Hosting Multiple Websites Under One NearlyFreeSpeech Site

2025-02-14

It's no secret that I'm a happy customer of [NearlyFreeSpeech.NET](https://nearlyfreespeech.net) (NFS). I've previously written about [installing WordPress](/posts/Installing_WordPress_on_NearlyFreeSpeech/) on their platform, and also published wikis on both setting up [ikiwiki](/ikiwiki/NearlyFreeSpeech/) and [cgit](/wiki/cgit/). Recently, I decided to move all personal and project websites *back* over to NFS after having a less than ideal VPS experience. I made the switch a couple weeks ago, and now I thought I would share my setup on how I run all my websites through a *single* NFS "site".

Let's get into it.

## Configure DNS

Before we do anything else, you will need to make sure that your desired domains point to the NFS [DNS](https://www.nearlyfreespeech.net/services/dns). If, like me, you have your domains registered through NFS this will be done automatically. Give this some time to propagate before moving forward.

## Per-Alias Sites

NFS allows you to host multiple websites through one of the "sites" by configuring them as **per-alias sites** or **document root**. You can enable this inside your "site" dashboard under `Config Information`:

<figure>
  <img src="/public/images/nfs-per-alias.webp" alt="Screenshot showing the UI toggle for Per-Alias Document Root">
  <figcaption>The option to toggle Per-Alias Document Root.</figcaption>
</figure>

Once that is active, simply add all your additional domains via the **Add a New Alias** in that same dashboard.

Every one of these site directories is required to be named after its associated domain name in order to work. On the server side of things, these directories are placed as sub-folders inside the main `/home/public/`, like so:

~~~sh
/home/public/website1.com/
/home/public/website2.com/
/home/public/website3.com/
~~~

## Sane Defaults

Using NFS comes with a solid set of helpful configurations. At a glance:

- Serves `gzip` compressed content
- Provides automatic TLS
- Practical caching options

But we can take this even further by tweaking a couple things ourselves...

## QoL Improvements

### Forwarding `www` to `non-www`

You could create symbolic links to target `www.example.com` to your existing `example.com` folder, but if you'd prefer to forward all `www` requests to your non-www counterpart (like me) you need to create a separate `www.example.com` directory.

So similar to how we setup our original domain directories:

~~~sh
/home/public/website1.com/
/home/public/www.website1.com/
...
/home/public/website2.com/
/home/public/www.website2.com/
...r
/home/public/website3.com/
/home/public/www.website3.com/
~~~

NFS serves all their client websites through Apache. This gives us the ability to utilize `.htaccess` files to dynamically forward `www` sets to their non-www variations. You just need to include a redirecting `.htaccess` file inside the root directory of your `www` domain directory. Like so:

~~~sh
RewriteEngine On
RewriteRule ^(.*)$ https://website1.com/$1 [R=301,L]
~~~

That's it for handling redirects.

### Beefing Up Security Headers

I also recommend setting up better Security Headers directly inside the `.htaccess` files associated with the core domain directories. Below are my own personal preferences in order to achieve an [A+ security rating](https://securityheaders.com/?q=btxx.org&followRedirects=on), but feel free to change these settings.

~~~sh
<IfModule mod_headers.c>
    # Enforce HTTPS and set HSTS (Strict-Transport-Security)
    Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"

    # Content Security Policy
    Header always set Content-Security-Policy "default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'; img-src 'self' data:; connect-src 'self'; font-src 'self'; frame->

    # Prevent Clickjacking (X-Frame-Options)
    Header always set X-Frame-Options "SAMEORIGIN"

    # MIME type sniffing prevention (X-Content-Type-Options)
    Header always set X-Content-Type-Options "nosniff"

    # Referrer Policy
    Header always set Referrer-Policy "no-referrer-when-downgrade"

    # Permissions Policy (Feature-Policy)
    Header always set Permissions-Policy "geolocation=(self), microphone=()"
</IfModule>
~~~

## Go Live

Include your website files in the proper domain sub folders on the server and you're done. Now you have a single point of entry for all your personal/project websites under one NearlyFreeSpeech "site". You also get to keep some extra coin in your wallet, since this will only cost you a fixed rate of $0.05 a day!
