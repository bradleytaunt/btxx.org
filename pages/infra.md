# Infrastructure

I try my best to self host as much as possible. The goal is to keep the setup clean, minimal, and low-power.

This setup won't allow me to claim "99.99% uptime" or blazing fast speeds, but it gives me full control and fits my basic requirements. The entire setup is sitting in the network / utility room of my basement.

**Last updated**: August 2026

<figure>
  <img src="/public/images/infrastructure-v2.webp" alt="A photo of my networking setup in my utility room">
  <figcaption>A glimpse of my networking setup: My secondary Mango mini router (VPN) on the left,  my Raspberry Pi Zero (Hermes) in the center, and my Raspberry Pi 3 (Apollo) on the right. Backup Pis are there for moral support.</figcaption>
</figure>

## Raspberry Pi 3B+ ([Apollo](https://apollo.btxx.org))

This is my main server. Used for my main blog and top-level side projects.

- **OS**: Alpine Linux (Running in RAM!)
- **CPU**: BCM2837 (4) @ 1.20 GHz
- **MEM**: 905.98MiB

### Hosting:

- [btxx.org](https://btxx.org) (this website!)
- [caddy.ninja](https://caddy.ninja)
- [wruby.site](https://wruby.site)

---

## Raspberry Pi Zero  v1.1 ([Hermes](https://hermes.btxx.org))

This is my secondary server. Used for most of my personal subdomains.

- **OS**: Alpine Linux (Running in RAM!)
- **CPU**: BCM2835 @ 1.00 GHz
- **MEM**: 427.87 MiB

### Hosting:

- [anon.btxx.org](https://anon.btxx.org)
- [audit.btxx.org](https://audit.btxx.org)
- [barf.btxx.org](https://barf.btxx.org)
- [cv.btxx.org](https://cv.btxx.org)
- [hermes.btxx.org](https://hermes.btxx.org)
- [jsfree.btxx.org](https://jsfree.btxx.org)
- [minwm.btxx.org](https://minwm.btxx.org)
- [normform.btxx.org](https://normform.btxx.org)
- [search.btxx.org](https://search.btxx.org)
- [shinobi.btxx.org](https://shinobi.btxx.org)
- [vanillacss.btxx.org](https://vanillacss.btxx.org)
- [zero.btxx.org](https://zero.btxx.org)

---

## NearlyFreeSpeech.NET

This is *not* self-hosted.

Used for all my side projects that require a more consistent up-time.

### Hosting:

- [1kb.club](https://1kb.club)
- [512kb.club](https://512kb.club)
- [1mb.club](https://1mb.club)
- [xhtml.club](https://xhtml.club)

---

## TierHive VPS

This is also *not* self-hosted.

Used for all OpenBSD related projects.

- **OS**: OpenBSD 7.9 amd64
- **CPU**: Intel Xeon D-1541
- **MEM**: 495MiB

### Hosting:

- [obsd.btxx.org](https://obsd.btxx.org/)
- [openbased.xyz](https://openbased.xyz)
- [httpd.rocks](https://httpd.rocks)

---

## RamHost VPS

This is also *not* self-hosted.

Used for all NetBSD related projects.

- **OS**: NetBSD 10.1 amd64
- **CPU**: AMD 686-class (1)
- **MEM**: 495MiB

### Hosting:

- [stats.bozo.httpd.rocks](https://stats.bozo.httpd.rocks/)
- [bozo.httpd.rocks](https://bozo.httpd.rocks)