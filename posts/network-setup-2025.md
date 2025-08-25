# My OpenBSD Home Network Setup

2025-08-25

I recently moved to an area with more internet provider options, all of which were *not* satellite-based. This change allowed me leave my current provider (Starlink) and also freed my network from being locked behind CGNAT. The jump from ~150Mbps to 1Gbps has been fantastic, but the real benefit in this switch has been the ability to overhaul my home network setup. 

My simple setup includes:

- Custom OpenBSD router
- Self-hosting my own web server
- Eeros setup as "dumb" APs

I plan to write-up an updated guide for building out my simple OpenBSD router (the older article can be [found here](/posts/openbsd-router)) and another tutorial for setting up an `httpd` web server on a Raspberry Pi 400 running OpenBSD, but today we will just look at the basics of my personal home network.

## The Setup

I know a lot of people have their networking devices beautifully organized,
allowing them to display all the hardware "out in the open". I'm not one of those people.
My network hardware is stored inside one of my basement utility closets, which
sits between my main basement and the room that houses my furnace and hot water tank. Classy, I know.

So please excuse the "dungeon" look in the photo below.

<figure>
<img src="/public/images/network-2025.jpg" alt="Photo of my network setup.
Shows a modem plugged into a small OpenBSD router, and a Raspberry Pi 400
plugged into that router via ethernet"/>
<figcaption>My network setup. Main modem is connected to the OpenBSD router,
which is the gatekeeper for everything else on the network.</figcaption>
</figure>

Let me further example the picture above:

1. The black device on the far left is my ISP's modem
2. The smaller black device in the back is a fanless mini PC (Intel Celeron J1900 4xi225V NIC) I picked up off Aliexpress. Currently running OpenBSD, acting as my main router/gateway
3. The Raspberry Pi 400 on the right side of the screen is my self-hosted web
   server (you're visiting a site on that server right now!)
4. **Bonus**: There is an older 32" TV off the to far right side. This is
   connected to the Raspberry Pi in case I need to perform any "onsite"
debugging or tweaking that can't be done remotely

I will also give a break down of the colored ethernet cords:

1. Yellow is the "internet" being fed from the modem to my router
2. Blue connects to my Eero Gateway (not pictured), which is setup in the main
   basement
3. Red connects to the Raspberry Pi server
4. White connects to my Xbox Series S (not pictured), also setup in the main
   basement

## Stats & Improvements

I consistently get ~900Mbps from devices connected directly to the OpenBSD
router, and ~280Mbps at the furthest part of my house (connected wirelessly to the 3rd
Eero mesh AP). Not too shabby.

I would love to replace my Eero APs with mesh devices running something like
OpenWRT, since these Amazon devices still "phone home". These Eeros where all I had on hand, 
so I'm just dealing with it for now...

(I do have one D-Link DIR-878 running OpenWRT already - so maybe just grabbing
a second one of those could work?)

## Closing Remarks

That's pretty much the gist of it. I plan to get those more details guides
posted soon, now that the craziness from the move has settled down. Hopefully
those can be a little more helpful for anyone interesed in setting up
a similar OpenBSD-based network.
