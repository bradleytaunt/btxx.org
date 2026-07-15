# Setup a Simple, Self-Hosted Web Server with OpenBSD
{:.no_toc}
2026-07-15

This very website is being served to you via `httpd` from my local HP T630 thin client running OpenBSD.

Pretty awesome, right? The best part is that you can *easily* do it too, even with limited knowledge of OpenBSD. Feel free to follow along if this is something you'd be inclined to try yourself. (Which I highly recommend!)

Also, if you're interested, I have more detailed specs about this local server posted on my [infrastructure page](/infra).

* toc
{:toc}

## Requirements

- Cheap, low spec VPS (checkout [Low End Talk](https://lowendtalk.com) for deals)
	- Why the VPS? This will allow us to hide our home IP from the nasty interwebs!
- Local server (thin client, mini PC box) that can run OpenBSD
- Coffee and a happy attitude!

But wait! I hear you question right away:

> "If you already have a VPS running OpenBSD, why not just use that to host your website?"

And you would be right. But that's not fun. That's boring. Isn't *having fun* the entire point of working with computers?! 

But you do whatever you like, I'm not your dad.

## Getting Started

I won't be covering the details of installing OpenBSD, since the core installer does an excellent job itself. I'll assume you have base OpenBSD running on both your VPS of choice and your local server.

First thing we need to do is install Wireguard on both machines:

~~~sh
pkg_add wireguard-tools
~~~

Then we need to generate both private and public keys (again, on both machines):

~~~sh
umask 077
wg genkey | tee private.key | wg pubkey > public.key
~~~

Take note of each machine's private and public key sets. Make sure to delete these key files once you include them to the configuration files below.

## The VPS

On the VPS create a new file `/etc/hostname.wg0`:

~~~sh
wgkey <VPS_PRIVATE_KEY>
wgport 51820
wgpeer <HOME_PUBLIC_KEY> wgaip 10.10.0.2/32
inet 10.10.0.1/24
~~~

Bring this up right now with `sh /etc/netstart wg0`. The best part is that this will automatically be persistent. OpenBSD saves us the hassle of needing to setup or enable any kind of "service".

Now we enable forwarding on our VPS:

~~~sh
echo 'net.inet.ip.forwarding=1' | doas tee -a /etc/sysctl.conf && doas sysctl net.inet.ip.forwarding=1
~~~

And finally, a basic `pf.conf` to tie everything together:

~~~sh
home      = "10.10.0.2"
tunnel_ip = "10.10.0.1"

set skip on lo
block return
pass out

pass in on egress inet proto tcp to port 22
pass in on egress inet proto udp to port 51820

pass in  on egress inet proto tcp to port { 80 443 } rdr-to $home
pass out quick on wg0 inet proto tcp to $home port { 80 443 } nat-to $tunnel_ip

pass on wg0
~~~

Load it right away with `pfctl -f /etc/pf.conf`. Nothing is going to work just yet, but we're getting there!

## The Local Server

Now on your home (local) server, create a similar `/etc/hostname.wg0`:

~~~sh
wgkey <HOME_PRIVATE_KEY>
wgpeer <VPS_PUBLIC_KEY> wgendpoint <VPS-IP> 51820 wgaip 10.10.0.1/32 wgpka 25
inet 10.10.0.2/24
~~~

And then bring it up just like the VPS: `sh /etc/netstart wg0`.

Finally, create the local server's `pf.conf`:

~~~sh
set skip on lo
set limit states 100000
set timeout interval 10
set optimization "normal"

table <block_table> persist
table <bruteforce> persist

block all
block in quick from <block_table>
block in quick from <bruteforce>

pass out quick

# SSH from LAN only
pass in proto tcp from 192.168.1.0/24 to port 22 keep state

# web, arriving over the tunnel
pass in on wg0 proto tcp to port { 80 443 } keep state

# base defaults
block return in on ! lo0 proto tcp to port 6000:6010
block return out log proto { tcp udp } user _pbuild
~~~

Feel free to tweak general rules to your liking and be sure to target the appropriate IP range found under the `SSH from LAN only` section to match your own network. Just keep in mind that you need keep things cleanly open for your tunnel.

### Basic Web Server

For this guide we will just make a simple, HTTP-only website. I have a separate guide focused solely on `httpd` (along with enabling extras like `relayd`) found here: [httpd.rocks](https://httpd.rocks).

Before going any further, make sure your desired domain has it's DNS A Records pointing at your VPS IP. Give it time to propagate and then continue.

Make our website directory:

~~~sh
doas mkdir -p /var/www/htdocs/reallycoolsite.com
~~~

Place your website files into this new folder and set proper permissions:

~~~sh
doas chmod -R 755 /var/www/htdocs/reallycoolsite.com
doas chown -R www:www /var/www/htdocs/reallycoolsite.com
~~~

Create the initial `/etc/httpd.conf` file:

~~~sh
server "reallycoolsite.com" {
    listen on * port 80
    root "/htdocs/reallycoolsite.com"
}

server "www.reallycoolsite.com" {
    listen on * port 80
    root "/htdocs/reallycoolsite.com"
    block return 301 "http://reallycoolsite.com$REQUEST_URI"
}
~~~

Check that the configuration has no errors, then get `httpd` up and running:

~~~sh
doas httpd -n
doas rcctl start httpd
~~~

And that's it! You should see your website live (although without HTTPS support for now). Congrats!

## Give Back to the Community

If you ended up running your own server based on this guide or even found it a little interesting, consider donating to either OpenBSD or Wireguard directly:

- [Donate to OpenBSD](https://www.openbsd.org/donations.html)
- [Donate to Wireguard](https://www.wireguard.com/donations/)

We wouldn't have the ability to make awesome stuff like this without the existence these incredible pieces of open software!

