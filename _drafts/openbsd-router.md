# Building a Simple Router with OpenBSD
{:.no_toc}

2025-07-10

I'm hardly a "networking" or system admin expert. Even still, I've always been interested in the concept of building out my own home router with OpenBSD. It seemed so "hacky" and cool! The problem is that most of the tutorials I stumble across on the internet seem so *daunting*. I normally read through the guides (maybe even poke around the core `man` docs for a bit as well) but always end up returning to my default ISP setup.

But that all changes today! Best of all, you can come along for the ride!

## My Networking Goals
{:.no_toc}

This article will be broken down into multiple parts to keep things simple. You can technically stop right after setting up the router in the first section, but I will also include some extra, personal quality of life improvements.

These sections will be as follows:

1. Setting up an OpenBSD router to funnel all traffic from my ISP (IPv4 only)
2. Configuring DNS and running a built in ad-blocker network-wide
3. Enabling port forwarding on my Xbox to avoid Strict NAT when gaming online

* toc
{:toc}

## The Hardware

- Mac Mini 2012, running OpenBSD 7.7
- TP-Link USB 3.0 to RJ45 Gigabit adapters
- Ethernet cables (Cat6)
- Gateway Eero (set to Bridge Mode)

Now, before you try to figure out why the heck I would turn a 2012 Mac Mini into a router (when there are so many better options available) understand this: it was sitting in a drawer in my office collecting dust. Waste not want not, right?

Since the Mac Mini is only equipped with a single ethernet port (which we need for the external WAN), I'm using some TP-Link USB adapters to mimic multiple ethernet LAN ports for any wired devices, like my Eero gateway and Xbox. These adapters are fully compatible with OpenBSD but other after-market dongles exist that should work just as well.

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

We don't need to install anything extra. All the software we need comes packaged with OpenBSD by default. Yet another reason this operating system is so incredible.

## Basic OpenBSD Router

### sysctl.conf

Before doing anything else, we need to ensure forwarding is enabled in our `/etc/sysctl.conf` file:

~~~
net.inet.ip.forwarding=1
~~~

### pf.conf

The meat-and-potatoes of this setup comes from within `/etc/pf.conf`. Make sure you have the following content:

~~~
ext_if = "bge0"
int_if = "axen0"

set skip on lo

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
    access-control: 192.168.1.0/24 alloww
    do-ip6: no
    verbosity: 1
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
  hardware ethernet 1C:1A:DF:74:A1:2F;
  fixed-address 192.168.2.100;
}
~~~

### Tweaking unbound.conf

~~~
server:
    interface: 192.168.1.1
    interface: 192.168.2.1
    access-control: 192.168.1.0/24 allow
    access-control: 192.168.2.0/24 allow
    do-ip6: no
    verbosity: 1
    include: "/var/unbound/etc/adblock/adblock.conf"

forward-zone:
    name: "."
    forward-addr: 1.1.1.1
    forward-addr: 9.9.9.9
~~~

## Backups

## Taking Things Further
