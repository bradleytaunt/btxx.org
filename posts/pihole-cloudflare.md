# Setting Up 1.1.1.1 for Families on a Pi-Hole

2021-10-28

After seeing Cloudflare's 1.1.1.1 for Families mentioned on the [front page of HackerNews](https://news.ycombinator.com/item?id=29024195), I thought it might be helpful to show those currently using a [pi-hole device](https://pi-hole.net) how to include 1.1.1.1 alongside it.

## Keeping Things Updated

It should go without saying that you should be running the latest stable pi-hole version for security and full feature support. To do so, simply `ssh` into your device (or connect to it directly if you prefer) and run the following to check your pi-hole version:


    pihole -v


And if your version is out of date, run:


    pihole -up


Once it completes the update everything will be good to go!

## Adding 1.1.1.1 (1.1.1.2)

Now you need to navigate to your main pi-hole admin in your browser (most likely the url will be *pi.hole*). Login in using your credentials and the do the following steps:

1. Navigate to **Settings**
2. Navigate to **DNS**
3. Under "Upstream DNS Servers" enter:

- Custom 1 (IPv4): 1.1.1.2
- Custom 2 (IPv4): 1.0.0.2


<figure>
    <img src="/public/images/pihole-cloudflare.webp" alt="PiHole setup admin dashboard">
    <figcaption>PiHole DNS settings (<a href="/public/images/pihole-cloudflare.webp">link to hi-res image</a>)</figcaption>
</figure>

## Ad-Block & Malware Protection

You now officially have protection against both intrusive advertisements *and* sites flagged with malware. Happy (and now safer) browsing!
