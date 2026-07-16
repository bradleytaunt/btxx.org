# Infrastructure

I try my best to self host as much as possible. The goal is to keep the setup clean, minimal, and low-power.

This setup won't allow me to claim "99.99% uptime" or blazing fast speeds, but it gives me full control and fits my basic requirements.

<figure>
  <img src="/public/images/t630.webp" alt="A stock photo of the HP T630 thin client">
  <figcaption>A stock photo of the HP T630, the same thin client that is serving you this very website!</figcaption>
</figure>

If you're interested in how to setup your own local server, I wrote about it here: [Setup a Simple, Self-Hosted Web Server with OpenBSD](/posts/self-hosted-openbsd)

## HP T630 Thin Client

This is my personal server. Used to host all of my personal project websites.

- **OS**: OpenBSD 7.9
- **CPU**: AMD Embedded G-Series GX-420GI R
- **MEM**: 7103MiB

You can find live stats here: [stats.openbased.xyz](https://stats.openbased.xyz)

---

## OpenBSD VPS

This is *not* self-hosted. Used to redirect all traffic to my self-hosted projects.

- **OS**: OpenBSD 7.9 amd64
- **CPU**: QEMU Virtual version (1) @ 1.996GHz
- **MEM**: 495MiB
