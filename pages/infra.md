# Infrastructure
{:.no_toc}

This page keeps track of all local services I am running in my house.

I try my best to self host as much as possible. The goal is to keep the setup clean, minimal, and low-power.

This setup won't allow me to claim "99.99% uptime" or blazing fast speeds, but it gives me full control and fits my basic requirements.

**Last updated**: July 2026

* toc
{:toc}

# Local

## Raspberry Pi Zero  v1.1 ([Hermes](https://hermes.btxx.org))

This is my secondary server. Used for most of my personal subdomains.

- **OS**: Alpine Linux (Running in RAM!)
- **CPU**: BCM2835 @ 1.00 GHz
- **MEM**: 427.87 MiB
- **SERVER**: nginx

This web server currently hosts:

- [anon.btxx.org](https://anon.btxx.org)
- [audit.btxx.org](https://audit.btxx.org)
- [barf.btxx.org](https://barf.btxx.org)
- [cv.btxx.org](https://cv.btxx.org)
- [jsfree.btxx.org](https://jsfree.btxx.org)
- [minwm.btxx.org](https://minwm.btxx.org)
- [normform.btxx.org](https://normform.btxx.org)
- [search.btxx.org](https://search.btxx.org)
- [shinobi.btxx.org](https://shinobi.btxx.org)
- [vanillacss.btxx.org](https://vanillacss.btxx.org)
- [zero.btxx.org](https://zero.btxx.org)

## DLink DIR-878

This is my home router running OpenWrt. Wifi is disabled. 

Wireless connections are handled by a set of eeros (set in bridge mode).

Pretty simple stuff.

## Raspberry Pi 400 (Jellyhole)

This device is running the following local services:

- Jellyfin media server
- Pi-Hole Adblock

## GL.iNet Mango Travel Router

The tiny yellow router. This mango is used for my "always-on" VPN wifi access point. I can run Wireguard or specific VPN GUI apps directly on a handful of my machines, but it's nice to have a dedicated AP you can instantly connect to.

---

<br/>

# External

## Source Code Forges

I use Sourcehut as main forge but offer Codeberg as a more accessible option for my public clubs / side projects.

- [Sourcehut](https://sr.ht/~bt/)
- [Codeberg](https://codeberg.org/btxx)

## NearlyFreeSpeech.NET

For more "public-facing" and up-time dependent projects, I use NearlyFreeSpeech hosting. These projects include:

- [btxx.org](https://btxx.org) (this website!)
- [1mb.club](https://1mb.club)
- [512kb.club](https://512kb.club)
- [1kb.club](https://1kb.club)
- [xhtml.club](https://xhtml.club)
- [wruby.site](https://wruby.site)

## TinyKVM VPS

For all my OpenBSD-specific projects I use RAMHost's TinyKVM offerings. These projects include:

- [openbased.xyz](https://openbased.xyz)
- [httpd.rocks](https://httpd.rocks)