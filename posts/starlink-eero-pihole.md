# Setting Up Pi-Hole with Eero on Starlink

2024-07-24

A couple years ago I wrote about [setting up a standard pi-hole server with eero WiFi](/posts/eero/) but since that time I have swapped out my "cell tower" internet for Starlink. The speed improvement has been incredible and there is no looking back at regular, rural internet. With the switch over minor adjustments needed to be made, so I took this as an opportunity to rebuild everything from scratch. A nice, clean slate.

## Required Equipment

For the purposes of the tutorial, I will assume that you have:

* Starlink setup and running
  * The official Starlink Ethernet adapter (if your model requires it)
* Eero mesh WiFi setup and running
* An Ethernet hardware switch
* A Raspberry Pi Zero (with WiFi preferred)
* (Optional) Ethernet connection HAT for the RPi0

It might sound like a lot, but it really isn't that complex - I promise!

## Getting Started

If you have the eero mesh network setup already, I will assume you have gone through the following steps:

1. Placed Starlink into bypass mode
2. Connected your Starlink router to the Ethernet hardware switch
3. Connected your Ethernet switch to your main eero router

With all of that working properly, our next step is to configure our Raspberry Pi device.

## Flashing Our Pi

Download the [Raspberry Pi Lite OS](https://downloads.raspberrypi.com/raspios_lite_armhf/images/raspios_lite_armhf-2024-07-04/2024-07-04-raspios-bookworm-armhf-lite.img.xz). Then, connect your desired microSD card to your computer and launch the official Raspberry Pi Imager. 

* Select "Custom Image" use the Raspberry Pi Lite OS you just downloaded
* Choose your device (in this case the microSD)

![Raspberry Pi Imager showing the image and device output to write the files](/public/images/starlink-pihole-1.webp)

When you click `Next`, you will be prompted to edit settings. Click `Yes`, fill out your custom details below and enable `ssh`:

![Raspberry Pi Imager showing customization options](/public/images/starlink-pihole-2.webp)

> **Note:** If you do not have an Ethernet HAT or adapter, but sure to add your WiFi details in the settings so your device will connect to your local network on boot.

![Raspberry Pi Imager enabling SSH](/public/images/starlink-pihole-3.webp)

Click `Save` and then proceed to write to the device.

![Raspberry Pi Imager writing the image to the microSD card](/public/images/starlink-pihole-4.webp)

After it completes, eject the microSD card and get your Pi device ready!

## Connecting Our Pi

Before we try to `ssh` into our Pi, we need to set things up properly on the hardware side of things. You will need to connect an Ethernet cable from your Raspberry Pi to a port on your main eero router. If you don't have an Ethernet HAT (or adapter cord) you can connect via WiFi once the Pi is powered on.

Take a look at the diagram below for reference.

![Diagram showing a Starlink router, connected with an Eero device with a pi-hole](/public/images/starlink-pihole-setup.webp)

Once everything is setup, plug-in your Raspberry Pi and give it a little bit of time to boot. Once you see a nice solid green LED, it's time to go back to your local computer's terminal.

## Installing Pi-Hole

Once at your terminal, connect to your Raspberry Pi:

~~~sh
# if you set a hostname
ssh pi@raspberrypi.local

# or just the IP
ssh 192.168.*.*
~~~

Then enter the username and password you created when you initially configured the microSD image. Once you are connected directly to the Pi, it’s best to check for updates:

~~~sh
sudo apt update
sudo apt upgrade
~~~

Now for the easy part - installing Pi-Hole:

~~~sh
curl -sSL https://install.pi-hole.net | bash
~~~

Just follow the guided setup (it is pretty straight-forward):

![Pi-Hole installer, selecting DNS](/public/images/starlink-pihole-5.webp)

Select `Yes` when asked to install the Web Admin Interface:

![Pi-Hole installer, choosing to install the web admin interface](/public/images/starlink-pihole-6.webp)

![Pi-Hole installer, terminal showing the web interface installing](/public/images/starlink-pihole-7.webp)

Once that completes you'll be shown your Pi-Hole's IPv4 and IPv6 addresses. **Keep note of these for later**.

## Configuring the Eero App

1. Open the Eero app (iOS or Android)
2. Navigate to `Settings` > `Network Settings` > `DNS`
3. Select Customized DNS and enter both your saved `IPv4` / `IPv6` values
4. Eero will prompt you to reboot your network - do it

Next we need to add your Pi-hole's address as an port forward reservation:

1. In the Eero app, navigate to `Settings` > `Network Settings` > `Reservations & port forwarding`
2. The Pi-Hole device should be listed automatically (if not, enter the Pi-Hole's IP manually)
3. Save your changes

You might be required to reboot your network again. Once that is complete we can now access our Pi-Hole's web interface!

## Pi-Hole Interface

Navigate to the Pi-Hole's IP (or the hostname you created for it) on your local computer. From here you can tweak the device settings as much or as little as you'd like! Enjoy ad-free and tracker-free browsing!

![Pi-Hole running locally in the browser](/public/images/starlink-pihole-8.webp)
