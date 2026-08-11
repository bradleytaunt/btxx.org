# Stuffing an SSD Inside the Raspberry Pi 400

2021-08-13

I have successfully jammed an mSATA SSD into the main shell of my Raspberry Pi 400. It wasn't as straightforward as I thought it would be - in fact, most *real* hardware tinkerers will probably vomit in their mouths once they see how I achieved this...

But I'm happy with my build. Those with better skills and knowledge can most likely improve upon this concept (and please do if you can - I'd love to see it!)

Enough chit-chat - on to the build!

## The Finished "Masterpiece"

Below you can see the final look of my modded Raspberry Pi 400, which I have personally named the **Raspberry Pi 400X**:

<figure>
    <img src="/public/images/pi-400-final.webp" alt="Pi 400 with internal SSD">
    <figcaption>The finished Raspberry Pi 400X (<a href="/public/images/pi-400-final.webp">link to hi-res image</a>)</figcaption>
</figure>

Do you see that ugly black USB-C to USB-A cable jutting out from the top? That little guy connects directly to the mSATA SSD *inside* the plastic keyboard structure and allows us to boot via USB. It also gives us the flexibility to easily *unplug* the internal SSD for times when we desire to boot from micro SD or a different USB device altogether.

So, how did I make this?

## The Shopping List

Before we deep dive into the terrible hardware modifications I've made to my Pi, I'll list out all the items/tools I used during the making of this monstrosity:

- mSATA 64GB SSD Half Size (KingSpec) &rarr; [AliExpress](https://www.aliexpress.com/item/32385499968.html?spm=a2g0s.9042311.0.0.210e4c4dIH8xWv)
- mSATA to USB 3.1 enclosure (gutted) &rarr; [Amazon](https://www.amazon.ca/gp/product/B07BBM3BVS/ref=ppx_yo_dt_b_asin_title_o09_s00?ie=UTF8&psc=1)
- Dremel rotary tool with soft sanding bits
- Metal cutting scissors / knife
- Electrical tape
- Patience

## Modding the Raspberry Pi 400

The final product requires us to attach the half size mSATA SSD to the (gutted) enclosure and then insert that directly inside the Pi (next to the lock port / ethernet). Our first step will be to disassemble the Pi 400, safely remove the keyboard module and remove the metal heatsink.

With your trusty metal cutting scissors (or whatever tool you prefer) you will need to cut out room for our enclosure internals to fit within:

<figure>
    <img src="/public/images/pi-heatsink.webp" alt="The cutout heatsink">
    <figcaption>I drew the outline of the enclosure on the metal first before cutting. (<a href="/public/images/pi-heatsink.webp">direct link to image</a>)</figcaption>
</figure>

Next you will need to carefully remove the Pi board itself from the red part of the case. Once placed safely aside, it's time to bust out our sanding dremel and remove the jutting plastic blocking our soon-to-be-added SSD. Remember to wear a mask during this phase, since breathing in plastic dust and fumes is not fun!

**Important to note:** this will remove one of the screw slots needed to secure the heatsink into the board. Not a big deal if you ask me...



<figure>
    <img src="/public/images/pi-plastic-back.webp" alt="Plastic dremled back">
    <figcaption>Here you can see my terrible sanding job on the far left plastic snap-lock (<a href="/public/images/pi-plastic-back.webp">direct link to image</a>)</figcaption>
</figure>

While you have the Pi board removed you should also cut out a slot for the USB-C to USB-A cable to connect our mSATA to one of our USB 3 ports on the Pi. For this I've opted to butcher the lock port (will I ever really use that anyway?)

<figure>
    <img src="/public/images/pi-outer-port.webp" alt="Back of the Pi opening">
    <figcaption>Don't judge...I'm sure most people could do a cleaner job! (<a href="/public/images/pi-outer-port.webp">direct link to image</a>)</figcaption>
</figure>

Now all that's left is to insert our gutted mSATA enclosure (with the half size SSD attached of course)
, tape it down with some hideous electrical tape and close this bad boy back up!

<figure>
    <img src="/public/images/pi-internal-ssd.webp" alt="The internal SSD">
    <figcaption>Take note of the tiny triangle piece of foam on the Type-C connector. This helps avoid direct contact with the back of the keyboard module! (<a href="/public/images/pi-internal-ssd.webp">link to hi-res image</a>)</figcaption>
</figure>

That's it! You now have the portable power of the Raspberry Pi 400, but now with the speed and performance of an SSD!

## The Performance Gains

|Storage Type|Seq. Write|Random W|Random R|
|------------|----------|--------|--------|
|Micro SD Card|17818 KB/sec|812 IOPS|2335 IOPS|
|mSATA SSD|206738 KB/sec|14615 IOPS|17925 IOPS|

I think it's pretty clear that the SSD blows the default micro SD card out of the water...

## Closing Thoughts

Now clearly you could just plug-in an external SSD and walk away with the same performance boosts - but where is the fun in that?

If anyone decides to improve on this or make a cleaner approach, please do share it with me. I'd love to see it!
