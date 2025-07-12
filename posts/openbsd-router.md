# Building a Simple Router with OpenBSD

2025-07-11

I'm hardly a "networking" or system admin expert. Even still, I've always been interested in the concept of building out my own home router with OpenBSD. It seemed so "hacky" and cool! The problem is that most of the tutorials I stumble across on the internet seem so *daunting*. I normally read through the guides (maybe even poke around the core `man` docs for a bit as well) but always end up returning to my default ISP setup.

But that all changes today! Best of all, you can come along for the ride!

> If you notice something incorrect, please [open a patch or ticket](https://codeberg.org/btxx/btxx.org) and let me know!

## Before We Begin
{:.no_toc}

This article will be broken down into multiple parts to keep things simple. You can technically stop right after setting up the router in the first section, but I will also include some extra, personal quality of life improvements.

These sections will be as follows:

1. Setting up an OpenBSD router to funnel all traffic from my ISP (IPv4 only)
2. Configuring DNS and running a built in ad-blocker network-wide
3. Enabling port forwarding on my Xbox to avoid Strict NAT when gaming online

The WiFi will also be handled entirely by the Eero AP (nothing direct on the router itself).

Good? Now let's get started.

* toc
{:toc}

## The Hardware

Your devices may vary, but my own setup is as follows:

- Mac Mini 2012, running OpenBSD 7.7
- TP-Link USB 3.0 to RJ45 Gigabit adapters
- Ethernet cables (Cat6)
- Gateway Eero (set to Bridge Mode)

Now, before you try to figure out why the heck I would turn a 2012 Mac Mini into a router (when there are so many better options available) understand this: it was sitting in a drawer in my office collecting dust. Waste not, want not - right?

Since the Mac Mini is only equipped with a single ethernet port (which we need for the external WAN), I'm using some TP-Link USB adapters to mimic multiple ethernet LAN ports for any wired devices, like my Eero gateway and Xbox. These adapters are fully compatible with OpenBSD but other after-market dongles exist that should work just as well.

With all of the hardware on-hand, do the following:

- Plug an ethernet cable from your ISP's modem into the ethernet port on the Mac Mini
- Plug in the USB to ethernet adapter into one of the USB 3.0 ports on the Mac Mini
- Connect an ethernet cable from the adapter to the main Eero gateway

Diagram for reference:

~~~diagram
          [ISP Modem]
               |
               |
      (WAN Ethernet cable)
               |
               |
          [Mac Mini]
               |
               |
   (USB to Ethernet adapter)
               |
               |
            [Eero]
~~~

<div class="alert note">
<span><b>Note:</b> If you're using a Eero device for your main gateway/AP device, make sure it is configured to operate in Bridge Mode before moving on to the next steps.</span>
</div>

## The Software

This guide is based on the assumption that you have already [installed OpenBSD](/wiki/openbsd/installation/) and configured your main `user` and preferences to your liking. We don't need to install anything extra on top of base. All the software we need comes packaged with OpenBSD by default. Yet another reason this operating system is so incredible.

## Basic OpenBSD Router

All of these edits take place on your router device (ie. Mac Mini). You can do this directly on the device itself with an external monitor and keyboard setup, or connect a secondary device through ethernet and simply `ssh` into the machine. The choice is yours!

### sysctl.conf

Before doing anything else, we need to ensure forwarding is enabled. Create (or edit if it already exists) your `/etc/sysctl.conf` file:

~~~
net.inet.ip.forwarding=1
~~~

You can reboot for the changes to be applied, or run it immediately:

~~~
doas sysctl net.inet.ip.forwarding=1
~~~

### pf.conf

The meat and potatoes of this setup comes from within `/etc/pf.conf`. Make sure you have the following content inside:

~~~
ext_if = "bge0"
int_if = "axen0"

set skip on lo

# Block everything by default
block all

# Normalize incoming packets
match in all scrub (no-df random-id max-mss 1440)

# Protect against spoofing
antispoof quick for { lo $int_if }

# NAT for LAN to WAN
match out on $ext_if from 192.168.1.0/24 to any nat-to ($ext_if)

# Allow all outbound traffic (router + LAN)
pass out on $ext_if keep state

# Allow LAN clients to initiate connections to router
pass in on $int_if
~~~

I've included some basic comments inline, but let's go through each item line-by-line for extra clarity.

~~~
ext_if = "bge0"
int_if = "axen0"
~~~

- These are set variables representing your interfaces on your router (Mac Mini). For my device `bge0` is the built in ethernet port, while the `axen0` is the USB to ethernet dongle connected to my Eero Gateway. You can check your own interfaces by running `ifconfig` (also be sure that the targeted device is up: `ifconfig <interface-name> up`).

~~~
set skip on lo
~~~

- Skips packet filtering on loopback.

~~~
block all
~~~

- Block all sources by default (before telling it what to explicitly allow)

~~~
match in all scrub (no-df random-id max-mss 1440)
~~~

- This helps avoid fragmentation attacks for incoming traffic.

~~~
antispoof quick for { lo $int_if }
~~~

- Defends against forged source IPs, especially on the LAN interface. This is very important.

~~~
match out on $ext_if from 192.168.1.0/24 to any nat-to ($ext_if)
~~~

- Applies NAT (source translation) to traffic from LAN going to the internet.

~~~
pass out on $ext_if keep state
~~~

- This keeps things secure by allowing stateful outbound traffic from LAN.

~~~
pass in on $int_if
~~~

- Accepts traffic from the LAN side. This is required in order for the router to work at all.

With that completed, simply reload your `pf.conf`:

~~~
doas pfctl -f /etc/pf.conf
~~~

That's it. *Technically* you can stop right here and have working internet funneling through your OpenBSD router. But maybe you want to setup a WiFi access point, enable DNS routing, or include some network-wide ad blocking? If so, continue reading!

## DNS Routing and Blocking Ads

Before editing anything else, we need to configure our `/etc/hostname.axen0` file:

~~~
inet 192.168.1.1 255.255.255.0
~~~

Then reload the network:

~~~
doas sh /etc/netstart
~~~

### adblock.conf

If you wish to include network-wide ad-block, I suggest using the StevenBlack host list. Before we get into that though, we need to create our blacklist zone file:

~~~
doas mkdir -p /var/unbound/etc/adblock
cd /var/unbound/etc/adblock
~~~

Then pull down the latest set of blocked hosts:

~~~
doas ftp https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
~~~

We can't use this `hosts` file directly, since it needs to be converted for `unbound`. The following script will help us with this (you might wish to set this up as a cronjob to stay up-to-date):

~~~
doas sh -c "grep '^0\.0\.0\.0' hosts | awk '{print \"local-zone: \\\"\"\$2\"\\\" static\"}' > adblock.conf"
~~~

Your ad-block configuration file will now be located at: `/var/unbound/etc/adblock/adblock.conf`. We will be using this in the next step.

### unbound.conf

For this example, we will piggyback off the DNS of both Cloudflare and Quad9 (feel free to change these!). Edit the `/var/unbound/etc/unbound.conf` file with the following:

~~~
server:
    interface: 192.168.1.1
    access-control: 192.168.1.0/24 allow
    do-ip6: no
    verbosity: 1
    hide-identity: yes
    hide-version: yes
    harden-glue: yes
    harden-dnssec-stripped: yes
    use-caps-for-id: yes
    prefetch: yes
    include: "/var/unbound/etc/adblock/adblock.conf"

forward-zone:
    name: "."
    forward-addr: 1.1.1.1
    forward-addr: 9.9.9.9
~~~

Notice the `include` that pulls in our generated ad-block file? Make sure `unbound` is enabled and start it:

~~~
doas rcctl enable unbound
doas rcctl start unbound
~~~

### dhcpd.conf

Now we can configure our main DHCP. Update your `/etc/dhcpd.conf` with the following in order to play nicely with the newly setup `unbound` and ad-block services:

~~~
subnet 192.168.1.0 netmask 255.255.255.0 {
  range 192.168.1.100 192.168.1.199;
  option routers 192.168.1.1;
  option domain-name-servers 192.168.1.1;
}
~~~

Then be sure to enable and start it:

~~~
doas rcctl enable dhcpd
doas rcctl start dhcpd
~~~

## Avoiding Strict NAT for Online Gaming

Congrats! We have DNS setup through Cloudflare and Quad9, pesky ads are being blocked at the network level, and our "dumb" AP device is handling all of our WiFi needs. Everything is coming up Milhouse!

But oh no! When I try to play some online games my Xbox complains about having a Strict NAT type. This will make playing with others *extremely* difficult... Lucky for us, there is a solution!

### Updating Our Hardware Setup

Connect another TP-Link USB-to-ethernet adapter directly to the Xbox. This will be discoverable under `ifconfig` (just like before) and will be named something like `axen1`. We need to update this specific LAN (and it's associated console) with the proper port forwarding to enable an Open NAT when gaming.

A diagram of the updated hardware setup:

~~~diagram
          [ISP Modem]
               |
               |
      (WAN Ethernet cable)
               |
               |
          [Mac Mini]
             /   \
            /     \
 (LAN Ethernet)  (LAN Ethernet)
        /             \
    [Eero]          [Xbox]
~~~

## hostname.axen1

Just like with our initial `axen0` hostname, we need to configure our `/etc/hostname.axen1` file now that the Xbox is wired:

~~~
inet 192.168.2.1 255.255.255.0
~~~

Then reload the network:

~~~
doas sh /etc/netstart
~~~

### Tweaking pf.conf

Update the `/etc/pf.conf` file with the following:

~~~
ext_if = "bge0"
int_if = "axen0"
int2_if= "axen1"
xbox_live_tcp_ports = "{ 53, 80, 3074 }"
xbox_live_udp_ports = "{ 53, 88, 500, 3074, 3544, 4500, 8083, 1780, 49164 }"
xbox = "192.168.2.100"

set skip on lo

# Block everything by default
block all

# Perform source-port randomization for all hosts which are not the xbox
match out log on egress from !$xbox to any nat-to ($ext_if:0) port 1024:65535

# Do not perform source-port randomization for the xbox - IMPORTANT
match out log on egress from  $xbox to any nat-to ($ext_if:0) static-port

# Normalize incoming packets with scrub options
match in all scrub (no-df random-id max-mss 1440)

# Protect against spoofing
antispoof quick for { lo $int_if $int2_if }

# Allow LAN clients to connect through router
pass in on $int_if
pass in on $int2_if

# Xbox port forwarding
pass in quick on egress proto tcp from any to (egress) port $xbox_live_tcp_ports rdr-to $xbox
pass in quick on egress proto udp from any to (egress) port $xbox_live_udp_ports rdr-to $xbox

# Allow outgoing traffic from router and LAN
pass out on $ext_if keep state
~~~

This might look daunting but fear not! It is actually quite straight foward.

~~~
int2_if= "axen1"
xbox_live_tcp_ports = "{ 53, 80, 3074 }"
xbox_live_udp_ports = "{ 53, 88, 500, 3074, 3544, 4500, 8083, 1780, 49164 }"
xbox = "192.168.2.100"
~~~

- The `int2_if` is the USB-to-ethernet adapter connected to the Xbox
- `xbox_live_tcp_ports` and `xbox_live_udp_ports` are the tcp/udp ports we need to forward for Xbox online functionality to work properly (as per Microsoft's documentation)
- `xbox = "192.168.2.100"` hardcodes our Xbox's IP (we will set this statically in our `dhcpd.conf` in the next steps)

~~~
match out log on egress from !$xbox to any nat-to ($ext_if:0) port 1024:65535
match out log on egress from  $xbox to any nat-to ($ext_if:0) static-port
~~~

- Here we are telling our router to use specific ports for Xbox inside of default randomization

~~~
antispoof quick for { lo $int_if $int2_if }

pass in on $int2_if
~~~

- Need both of these to include our new USB adapter (`$int2_if`)

~~~
pass in quick on egress proto tcp from any to (egress) port $xbox_live_tcp_ports rdr-to $xbox
pass in quick on egress proto udp from any to (egress) port $xbox_live_udp_ports rdr-to $xbox
~~~

- We finish things up by actually setting the port forwarding

### Tweaking dhcpd.conf

~~~
subnet 192.168.1.0 netmask 255.255.255.0 {
  range 192.168.1.100 192.168.1.199;
  option routers 192.168.1.1;
  option domain-name-servers 192.168.1.1;
}

subnet 192.168.2.0 netmask 255.255.255.0 {
  option routers 192.168.2.1;
  option domain-name-servers 192.168.2.1;
  range 192.168.2.100 192.168.2.150;
}

host xbox {
  hardware ethernet 11:22:33:44:55:66;
  fixed-address 192.168.2.100;
}
~~~

- Here we include subnet `192.168.2.0` which covers our adapter connected to our Xbox. We then hardset the console's IP with `fixed-address` (this will match what we previously set in `pf.conf`). Make sure you edit the `hardware ethernet` MAC address to match your own. This can be found in the Xbox UI under **Settings** > **Network** > **Advanced**.

### Tweaking unbound.conf

~~~
server:
    interface: 192.168.1.1
    interface: 192.168.2.1
    access-control: 192.168.1.0/24 allow
    access-control: 192.168.2.0/24 allow
    do-ip6: no
    verbosity: 1
    hide-identity: yes
    hide-version: yes
    harden-glue: yes
    harden-dnssec-stripped: yes
    use-caps-for-id: yes
    prefetch: yes
    include: "/var/unbound/etc/adblock/adblock.conf"

forward-zone:
    name: "."
    forward-addr: 1.1.1.1
    forward-addr: 9.9.9.9
~~~

- Same concept as `dhcpd.conf`, we need to include the new interface `192.168.2.1` for both the `interface` and `access-control`.

Now just reload all the services and everything should be solid!

~~~
doas rcctl restart dhcpd
doas rcctl restart unbound
doas pfctl -f /etc/pf.conf
~~~

Enjoy your router, working internet, and Open NAT on your Xbox!

## Advanced Settings

I like to keep things fairly minimal, so I have intentionally kept the setup fairly bare-bones. Therefore, this setup does not have working IPv6 or any other fancy services running in the background (ie. local servers, media storage etc.).  But don't let that stop you - feel free to add on and expand as you see fit!

(This article was published to the internet through an OpenBSD router!) :D
