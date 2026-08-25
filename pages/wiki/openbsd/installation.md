# Installing OpenBSD

Below you can find instructions for installing OpenBSD on a personal computer.

The example below covers installing **OpendBSD 7.5** on a X220 ThinkPad laptop.

## Requirements

* USB device
* Ethernet connection (with active internet)
* A cup of coffee

## Before the Install

Make sure you have the latest OpenBSD image formatted on your USB device and that your computer/laptop is set to boot from USB via the BIOS.

## Installation

1. Boot from USB
2. Choose `Install`
3. Keyboard layout: `us`
4. Hostname: `x220` (or whatever you choose)
5. Network: `em0`
6. IPv4: `autoconf`
7. IPv6: `none`
8. Network interface: `done`
9. Password for root
10. Start sshd by default? `yes`
11. X Window System start with xenodm? `no`
12. Setup user? `username` (follow setup user steps)
13. Allow root ssh login? `no`
14. Timezone
15. Which disk? Use internal (`sd0` etc.)
16. Encrypt root disk? `no`
17. Use `WHOLE` disk
18. Use `AUTO` layout
19. Which disk to initialize: `done`
20. Location of sets: `http`
21. HTTP Proxy URL? `none`
22. HTTP Server? `1` (Toronto)
23. Confirm again
24. Server directory? `pub/OpenBSD/7.5/amd64`
25. Set names? `done`
26. Drink some coffee while it verifies (depends on network speed)
27. Location of sets? `done`
28. Congrats!
29. Reboot and remove USB device

## First Boot Tweaks

### User Permissions

Before we do anything, we should give our main user full access via `doas`. Login as `root` and run the following:

~~~sh
echo "permit nopass :wheel" >> /etc/doas.conf
~~~

Now you can logout or reboot the machine.

Running any of the commands might present you with a permissions error. If that happens, simply add `doas` to the start of every command.

### Firmware

Once your machine reboots, login as your created user. The next steps will help you ensure you have the latest firmware.

Simply run the command: `fw_update`


### WiFi

To enable wifi on your device, run the following command (filling in the proper details where need be)

~~~sh
ifconfig iwn0 up
ifconfig iwn0 scan
echo "join WIFI-NAME wpakey PASSPHRASE" >> /etc/hostname.iwn0
echo "dhcp" >> /etc/hostname.iwn0
echo "inet6 autoconf" >> /etc/hostname.iwn0
echo "up powersave" >> /etc/hostname.iwn0
dhclient iwn0
~~~

Take note of the `iwn0`, as this might differ on your machine. (You can check this by running `ifconfig`)

You might also need to run `doas sh /etc/netstart` after.


### Performance Boost

This step is optional and targeted towards devices with batteries (obviously). Properly setup apmd:

~~~sh
rcctl enable apmd
rcctl set apmd flags -A
rcctl start apmd
~~~


## Next Steps

Now that the base system is up and running, it is time to setup our desktop environment:

[Setting up a Desktop Environment for OpenBSD &rarr;](/wiki/openbsd/desktop_environment)

