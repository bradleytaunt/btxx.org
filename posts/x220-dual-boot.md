# Dual Booting OpenBSD and Alpine Linux on a X220 ThinkPad

2024-07-10

I've always found it useful to run both OpenBSD and some form of Linux variation on my personal machines. Most times, I would default to running one OS on bare metal, while the other would simply live in a VM. This works *okay* but I prefer my operating systems having a "hardware separator" - if that makes sense? So, I set off to start dual booting both OpenBSD and Alpine Linux on my X220 ThinkPad.

I should mention that I planned to write this blog post a couple weeks ago, but the original Dogfish mSATA SSD I ordered wasn't compatible with my X220 (even though they say it is supported...). Luckily, I found a replacement drive in one of my "computer parts" drawer. Hoarding tech always prevails!

<figure>
  <img src="/public/images/dual-boot-2.webp" alt="The inside of my X220, showing the Dogfish mSATA drive in place.">
  <figcaption>The original Dogfish mSATA slotted in the X220. Too bad it didn't work...</figcaption>
</figure>

I came across my old Raspberry Pi 400, which I previously [wrote about when stuffing an SSD inside it](/posts/pi-400-internal-ssd/), and proceeded to gut the drive. It's a cheap KingSpec SSD with a whopping 64GB of storage space. But that didn't matter since the plan was to install the wonderfully small Alpine Linux. 64 GB would be plenty of space for us!

## Getting Started

I already had the Alpine Linux ISO installed on a random thumb drive, so that made things quicker right off the bat. The next step was opening up my X220 and slotting in the very tiny mSATA.

This introduced the first minor issue: the drive was too small. I could have looked into something more "professional-looking" in order to seat the drive properly but I decided to *stick* with electrical tape. Get it?... After applying the tape I closed the machine back up.

<figure>
  <img src="/public/images/dual-boot-3.webp" alt="The inside of my X220, showing the KingSpec mSATA drive in place with electrical tape.">
  <figcaption>The KingSpec mSATA slotted in the X220 and secured with top-of-the-line electrical tape...</figcaption>
</figure>

## Installing Alpine Linux

Next, I needed to tell the BIOS to boot into my thumb drive containing the Alpine ISO. Once the proper order was set, I rebooted the machine and ran through the standard Alpine installer. No problems to report there.

<figure>
  <img src="/public/images/dual-boot-4.webp" alt="My X220 booting into the Alpine ISO thumb drive">
  <figcaption>My X220 booting into the Alpine ISO thumb drive</figcaption>
</figure>

<figure>
  <img src="/public/images/dual-boot-5.webp" alt="The Alpine Linux installer showing both disk options for installation destination">
  <figcaption>The Alpine Linux installer showing both disk options for installation destination. SDA is currently running OpenBSD.</figcaption>
</figure>

Once that was done, I rebooted the machine, being sure to remove the thumb drive and set the BIOS order to point to the new mSATA disk. Then I ran through my personal [Alpine Suck installer](https://git.sr.ht/~bt/alpine-suck-installer) to get my go-to applications installed alongside my `dwm` desktop environment. Again, no problems to report during this process.

<figure>
  <img src="/public/images/dual-boot-6.webp" alt="Alpine Linux running the dwm desktop environment on my X220">
  <figcaption>Alpine Linux running my personal `dwm` setup. Absolutely beautiful.</figcaption>
</figure>

## Extras?

That's really it. Nothing super interesting to report, but that seems to be the running theme with these older ThinkPad machines: they were built for tinkering and taking apart regularly. If I was less lazy, I could look into setting up a boot loader to avoid swapping between disks via BIOS settings, but for my use case this setup works fine. Now I have the power of OpenBSD *and* Linux on my personal machine!
