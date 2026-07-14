# Infrastructure

I try my best to self host as much as possible. The goal is to keep the setup clean, minimal, and low-power.

This setup won't allow me to claim "99.99% uptime" or blazing fast speeds, but it gives me full control and fits my basic requirements.

<figure>
  <img src="/public/images/infrastructure.png" alt="A photo of my networking setup in my utility room">
  <figcaption>A glimpse of my networking setup: My secondary Mango mini router (VPN) on the left,  my Raspberry Pi Zero (Hermes) in the center, and my Raspberry Pi 3 (Apollo) on the right. Backup Pis are there for moral support.</figcaption>
</figure>

## Raspberry Pi 3B+ ([Hades](https://hades.btxx.org))

This is my personal server. Used for my personal blog/website.

- **OS**: Alpine Linux (Running in RAM!)
- **CPU**: BCM2837 (4) @ 1.20 GHz
- **MEM**: 905.98MiB

### Hosting

- [btxx.org](https://btxx.org) (this website!)

---

## Raspberry Pi 3B+ ([Apollo](https://apollo.btxx.org))

This is my main server. Used for all side projects.

- **OS**: Alpine Linux (Running in RAM!)
- **CPU**: BCM2837 (4) @ 1.20 GHz
- **MEM**: 905.98MiB

### Hosting

- [1kb.club](https://1kb.club)
- 1mb.club (soon!)
- 512kb.club (soon!)
- [caddy.ninja](https://caddy.ninja)
- [wruby.site](https://wruby.site)
- [xhtml.club](https://xhtml.club)

---

## Raspberry Pi Zero  v1.1 ([Hermes](https://hermes.btxx.org))

This is my secondary server. Used for most of my personal subdomains.

- **OS**: Alpine Linux (Running in RAM!)
- **CPU**: BCM2835 @ 1.00 GHz
- **MEM**: 427.87 MiB

### Hosting

- [anon.btxx.org](https://anon.btxx.org)
- [audit.btxx.org](https://audit.btxx.org)
- [hermes.btxx.org](https://hermes.btxx.org)
- [minwm.btxx.org](https://minwm.btxx.org)
- [search.btxx.org](https://search.btxx.org)
- [vanillacss.btxx.org](https://vanillacss.btxx.org)
- [zero.btxx.org](https://zero.btxx.org)

---

## TinyKVM VPS

This is *not* self-hosted. Used for all OpenBSD related projects.

- **OS**: OpenBSD 7.9 amd64
- **CPU**: QEMU Virtual version (1) @ 1.996GHz
- **MEM**: 495MiB

### Hosting

- [openbased.xyz](https://openbased.xyz)
  - [stats.openbased.xyz](https://stats.openbased.xyz)
- [httpd.rocks](https://httpd.rocks)