# Hosting a Website Entirely in RAM on a Raspberry Pi Zero

2026-04-10

My micro website, [zero.btxx.org](https://zero.btxx.org), is being served to the public internet from a Raspberry Pi Zero v1.3 running Alpine Linux. The best part? It's diskless and running entirely from memory!

This is even more impressive considering the Pi Zero only has `512MB` of total memory, `~40MB` of which is tied up running the OS. Since RAM is so abundant and cheap these days that we can... Oh, right.

Anyway, what a time to be alive!

Before we start, let's make a grocery list of all the required hardware items we need:

## The Hardware

- Raspberry Pi Zero v1.3
- 8GB+ microSD card (still needed for install and booting into RAM)
- Waveshare Ethernet HAT (optional, can use OTG adapter instead)
- Ethernet cable
- Micro USB power cord / power adapter
- Cool case (optional)

Additional hardware that will only be needed temporarily for the initial install of Alpine:

- Monitor
- HDMI to mini-HDMI adapter
- Keyboard

## Preparing Our microSD Card

The following was performed on macOS. Using a different operating system will require additional steps. Note that we will be extracting the `tar` content directly on to our microSD card, so make sure you download the Alpine image ending with `tar.gz`.

Plug in SD card and find the disk with `diskutil list`. For our example the SD card will be located at `/dev/disk4`.

Next, wipe and re-partition the card as FAT32:

~~~sh
diskutil eraseDisk FAT32 ALPINE MBRFormat /dev/disk4
~~~

Extract the Alpine tarball onto the card:

~~~sh
tar xzf alpine-rpi-*.tar.gz -C /Volumes/ALPINE
~~~

Clean up any macOS junk then eject it:

~~~sh
find /Volumes/ALPINE -name '._*' -delete
rm -rf /Volumes/ALPINE/.Spotlight-V100
rm -rf /Volumes/ALPINE/.fseventsd
rm -rf /Volumes/ALPINE/.Trashes

diskutil eject /dev/disk4
~~~

Now pop the microSD card into your Pi Zero. Be sure to have your Pi connected to a monitor and keyboard, then turn it on.

## Alpine Linux in Diskless Mode

## Optimizing Alpine Linux

### The Software

- **Alpine Linux (armhf)**
  - `dropbear`
  - `darkhttpd`
  - `lbu`
  - `rsync`

## Choosing a Web Server

## Choosing a CDN

## Backups

