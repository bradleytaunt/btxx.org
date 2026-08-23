# So Long Relayd, and Thanks for All the Fish
{:.no_toc}
2026-08-17

Running `relayd` alongside `httpd` on your OpenBSD web servers is no longer necessary for injecting HTTP security headers. Thanks to the incredible work by [rsadowski@](https://marc.info/?l=openbsd-cvs&m=178495844507568&w=2) we now have the ability to set our security headers directly inside `httpd`. Pretty awesome, right?

<div class="alert">
  <span><b>Note:</b> I still love <code>relayd</code> and I'm aware that it offers more than simply applying HTTP security headers. If you still prefer using it, that's okay! Please don't yell at me!</span>
</div>

* :toc
{:toc}

## Requirements

As of this time of writing (August 2026) you'll need to be running your system on OpenBSD `-current` in order to use these new header sets in `httpd`. If you're okay with being on the "cutting-edge", you can update by running the following:

~~~sh
doas sysupgrade -s
~~~

This will trigger a pull of the latest snapshot instead of the next release. Your machine will reboot into the installer automatically, upgrade, and then reboot again.

## Before &amp; After

Previously your web server would need to have both of the following in order to include HTTP security headers:

`/etc/httpd.conf`:

~~~sh
server "yourcooldomain.com" {
    alias "www.yourcooldomain.com"
    listen on * tls port 443
    root "/htdocs/yourcooldomain.com"
    hsts

    location "/.well-known/acme-challenge/*" {
        root "/acme"
        request strip 2
    }
    
    tls {
        certificate "/etc/ssl/yourcooldomain.com.crt"
        key "/etc/ssl/private/yourcooldomain.com.key"
    }
}
server "yourcooldomain.com" {
    alias "www.yourcooldomain.com"
    listen on * port 80

    location "/.well-known/acme-challenge/*" {
        root "/acme"
        request strip 2
    }

    block return 301 "https://$SERVER_NAME$REQUEST_URI"
}
~~~

`/etc/relayd.conf`:

~~~sh
ip4="YOUR IPv4"
ip6="YOUR IPv6"
table <www> { 127.0.0.1 }
log connection

http protocol https {
    match request header append "X-Forwarded-For" value "$REMOTE_ADDR"
    match request header append "X-Forwarded-By" \
        value "$SERVER_ADDR:$SERVER_PORT"
    match request header set "Connection" value "close"

    # Add security headers
    match response header append "Strict-Transport-Security" value "max-age=31536000; includeSubDomains; preload"
    match response header append "Cache-Control" value "public, max-age=86400"
    match response header append "Content-Security-Policy" value "default-src 'self'; script-src 'self'; object-src 'none';"
    match response header append "X-Content-Type-Options" value "nosniff"
    match response header append "X-Frame-Options" value "SAMEORIGIN"
    match response header append "Referrer-Policy" value "no-referrer"
    match response header append "Permissions-Policy" value "interest-cohort=()"
    
    match request header set "Accept-Encoding" value "gzip, deflate"
}

relay wwwtls {
        listen on $ip4 port 443 tls
        protocol https
        forward to <www> port 8080 check icmp
}
relay www6tls {
        listen on $ip6 port 443 tls
        protocol https
        forward to <www> port 8080 check icmp
}
~~~

But now we can place everything directly inside our `httpd.conf`, like so:

~~~sh
server "yourcooldomain.com" {
    listen on * tls port 443
    root "/htdocs/yourcooldomain.com"
    hsts

    # Security headers
    header set "Strict-Transport-Security" "max-age=31536000; includeSubDomains; preload"
    header set "Content-Security-Policy" "default-src 'self'; script-src 'self'; object-src 'none';"
    header set "X-Content-Type-Options" "nosniff" always
    header set "X-Frame-Options" "SAMEORIGIN" always
    header set "Referrer-Policy" "no-referrer" always
    header set "X-Permitted-Cross-Domain-Policies" "none" always
    header set "X-XSS-Protection" "0" always
    header set "Permissions-Policy" "interest-cohort=()"

    # Avoid info leak: strip the revealing header (optional)
    header remove "X-Powered-By"

    location "/.well-known/acme-challenge/*" {
        root "/acme"
        request strip 2
    }
    
    tls {
        certificate "/etc/ssl/yourcooldomain.com.crt"
        key "/etc/ssl/private/yourcooldomain.com.key"
    }
}
~~~

The above security header settings are just my personal preferences, this can be changed as you see fit. But that's it!

## Full Guide

If you'd like a more detailed guide that takes you through the entire process of setting up your own `httpd` web server running on OpenBSD, check it out here: [httpd.rocks](https://httpd.rocks)