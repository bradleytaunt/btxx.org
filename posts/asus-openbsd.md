# Liberating the ASUS CX1100CN Chromebook with OpenBSD

2026-01-16

I've always enjoyed the idea of having a portable, lightweight, 11 inch laptop for my personal use for around the house and small trips. A device that I wouldn't have to be concerned about just throwing in a backpack and forgetting about. Something inexpensive, that would allow me to shrug off breakage or theft.

So, I snagged an ASUS CX1100CN Chromebook off eBay for just $50 Canadian.

## The Specs

- **Processor**: Intel Celeron N3350 (1.1 GHz, dual-core)
- **Display**: 11.6-inch HD (1366 x 768 pixels) anti-glare display
- **RAM**: 4GB LPDDR4-SDRAM
- **Storage**: 32GB eMMC
- **Battery Life**: Up to 12 hours on a single charge (claimed by ASUS)
- **Connectivity**: Two USB-C ports, USB 3.2 Type A, microSD slot, audio jack

**Important note:** This laptop is *very* underpowered. 

I would not recommend this computer as a core programming or work device. Video playback cranks CPU usage to the max and opening more than 2 or 3 tabs in Firefox eats through memory. The battery life is pretty decent though, so that's nice...

## Enabling Developer Mode

Before we can do anything else we need to get our Chromebook booting into Developer Mode. While this is a fairly easy process, it does involve a little more detail than I plan to focus on this article. You can find an awesome guide directly from MrChrombox (whose firmware utility we are about to use!):

- [Putting your ChromeOS device into Developer Mode](https://docs.mrchromebox.tech/docs/boot-modes/developer.html)

Now that we have our device booting into Developer Mode, we can move onto the next step.

## Removing Write Protection

If you want to purge the default ChromeOS off most Chromebooks, you need to use MrChrombox's custom (and very awesome) [coreboot firmware](https://docs.mrchromebox.tech) utility. But in order to flash this firmware to your device you will need to disable the write protection. In the case of the ASUS CX1100CN, this requires booting into the device with the main battery disconnected or flashing the hardware directly via the [SuzyQable method](https://docs.mrchromebox.tech/docs/firmware/wp/disabling.html#using-closed-case-debugging-ccd-using-a-suzyqable).

I chose the easier battery-removal method because I don't trust myself enough with anything more advanced than that...

The next step involves removing the back cover and disconnecting the battery. This is fairly easy, as there is only one connector you need to unplug. Just be gentle with it.

<figure>
  <img src="/public/images/openbsd-chromebook-1.webp" alt="The back cover of the chromebook removed and the battery cable disconnected">
  <figcaption>The disconnected battery on the ASUS CX1100CN. The white connector is what you're looking for.</figcaption>
</figure>

<figure>
  <img src="/public/images/openbsd-chromebook-2.webp" alt="A close up of the battery connector">
  <figcaption>Extra, close-up (fuzzy) of the battery connector. Slide the connector off towards the battery - don't lift it straight up.</figcaption>
</figure>

With the battery disconnected, plugin your laptop adapter and boot it up. 

## Having Fun with Infinite Restarts

At this point my laptop randomly started rebooting over and over again until I unplugged it. I tried this a couple times but continued to run into this "infinite" reboot (and yes, my power adapter was the proper, original one). I decided to move on to the next steps anyway. This worked out, since you will see momentarily that write protection was properly removed!

This is more of a warning to be aware of that potential reboot "bug".

## Flashing the Firmware

Previously, you could run commands directly inside ChromeOS using `[CTRL+ALT+T]`. This no longer works since the removal of `sudo` from the crosh shell. Instead we will have to use the VT2 terminal.

Reconnect the battery and boot up the Chromebook. At the login screen, press `[CTRL+ALT+F2]` (`F2` is right-arrow on most ChromeOS keyboards) and then login with the following user (no password required):

- **username**: chronos

Once logged in, run the following:

~~~sh
cd; curl -LOf https://mrchromebox.tech/firmware-util.sh && sudo bash firmware-util.sh
~~~

From here you can follow the next steps and options in the [Firmware Utility Script overview](https://docs.mrchromebox.tech/docs/fwscript.html#firmware-utility-script). Be sure to select `Install/Update UEFI (Full ROM) Firmware` in order to properly install OpenBSD in the next steps! Backing up the original firmware is probably a good idea as well.

## Installing OpenBSD

Once that firmware utility is flashed we can reboot and install OpenBSD! Boot up your Chromebook with a OpenBSD Live USB plugged in and select it at the main boot menu.

<figure>
  <img src="/public/images/openbsd-chromebook-3.webp" alt="The glorious coreboot boot menu">
  <figcaption>It's alive! It's allliiiivvveee!</figcaption>
</figure>

Follow the standard (and very awesome) OpenBSD installer as you would for any other device. I have a [simple installation guide here](/wiki/openbsd/installation/), along with my streamlined ["suckless software" desktop setup script](https://git.sr.ht/~bt/open-suck-installer), if you're interested. Either way, you shouldn't run into any issues.

## "Can You Hear Me Now?"

That's really it. Most things work out of the box EXCEPT for sound through the speakers. It's a known issue with this specific Chromebook (even on Linux) but you can always use headphones, right? I warned you at the beginning that this device is far from ideal as a daily driver!

Hopefully this guide proves useful for anyone else out there looking to liberate their own ASUS CX1100CN or any Chromebook for that matter!

Good luck and have fun!
