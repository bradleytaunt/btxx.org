# Replacing My Eero Mesh Network with Two Mangos

2023-03-09

It has been one week since I retired my Eero mesh network setup and replaced it with two [Mango Mini Travel Routers (GL-MT300N-V2)](https://www.gl-inet.com/products/gl-mt300n-v2/). There were some obvious reasons to make this switch but I was initially unsure how the overall performance on the Mangos would hold up compared to the "cutting edge" tech that Eero devices claim to have.

Spoiler (in case the post title didn't give it away): I was pleasantly surprised.

## Goodbye Amazon

I was a big supporter of the original "kickstarter" project when Eero first launched. I pre-ordered and they even sent me a device free-of-charge since there were logistic problems shipping to Canada. I received my V1 routers, hooked them up and enjoyed a seamless, wifi mesh system. Everything was going great.

Then, in 2019 [they were acquired by Amazon](https://mashable.com/article/amazon-acquires-eero). Sigh...

I should have jumped ship then, but I waited to see what would happen. After all, my internet was still working perfectly fine. Then the half-baked and sometimes completely broken updates started rolling out. On more than one occasion they needed to perform complete version roll-backs. This sometimes knocked out my internet for hours at a time.

They also started pushing (although not outright requiring) users to login using their Amazon account. While not a massive deal breaker, the constant pestering to do so rubbed me the wrong way. 

During this time, my first son was born and we moved out of the city into our first house. So fiddling with my internet setup took the backseat for a while. Once everything settled down, I started seeing more broken updates and certain features being put behind their premium "Eero Secure" platform. Features that were available as *default* for most other router hardware providers.

So, I started to look at other options.

## Why the Mango?

It is important to mention, that because I live out in rural Canada, my internet options are extremely limited. All providers are satellite-based since fiber cables are unheard of out in these areas. Because of this, my main internet speeds are limited to 25Mbps *baseline*. This is important to note, since my experience and router choice took this into consideration. If you're a current Eero user with 300Mbps+ speeds and are looking to switch wifi systems - the Mango is probably not the best for you.

Luckily for me, the Mini Mangos were perfect for my basic requirements:

- Max. 300Mbps Wi-Fi Speed (more than enough for my use-case)
- Running open-source software via [openwrt](https://openwrt.org/)
- Hardware VPN toggle
- Tiny physical footprint
- Extremely portable

## Setting Up the Yellow Squares

<figure>
<img src="/public/images/mango-router-1.webp" alt="The Mango router from the left side">
<figcaption>The little yellow mango in all its glory...</figcaption>
</figure>

Setup was a breeze compared to the Eero experience (which could only be performed through their mobile app via bluetooth and a great deal of repositioning the devices). The full process is essentially:

1. Power up the first Mango
2. Connect laptop to the Mango via ethernet (you can also connect through wifi)
3. Follow the login instructions
4. Change SSID name, set device in router mode
5. Enjoy your internet!

Since my office is fairly far away from the placement of the "main" Mango router, I placed the second device near my desk. I followed the same setup as above, except I set the mode as "repeater".

For my use case I actually set this device up with a separate SSID. This was just my personal preference. You don't have to do this. If you give both devices the same SSID name most modern devices will treat your network as if it *was* a mesh network. Pretty neat stuff.

I plan to eventually add my Pi Zero running AdGuard Home back into the mix, but for now I just installed a small adblock package directly onto the router:

- [adblock package](https://github.com/openwrt/packages/tree/master/net/adblock)

## Performance Comparisons

Everything below is just some basic testing I performed. Obviously it should be noted that your experience might be entirely different based on interference, building size, amount of devices connected, etc.

Stats for my original Eero mesh setup:

- 1 eero 6 pro, 1 eero 6+, 1 eero beacon
- Average internet testing speed: 25Mbps
- Consistent signal throughout the house

Stats for the new Mini Mango setup:

- 2 mini mangos (one in router mode, the other set as repeater)
- Average internet testing speed: 25Mbps
- Consistent signal throughout the house

## Extras

Some additional data comparisons for those interested. Prices shown are in Canadian dollars.

||Eero|Mango|
|-----|----|-----|
|**Power**|5W|2.75W|
|**Size** (mm)|139x139x55|58x58x22|
|**Bands** (GHz)|2.4/5|2.4|
|**Cost** (per unit)|$99+|$39|

That mostly covers it. I'm extremely happy with my switch away from the locked-down, "upsell" heavy Eeros. My only regret is that I didn't make this change sooner.