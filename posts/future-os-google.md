# Chrome OS Could Become the Future Leader of Computing

2022-01-06

**FOSS Enthusiasts**: This article discusses the use of proprietary software and places it in a *positive* light. You have been warned. No angry emails please...

- - -

Google has created one of the best operating systems designed with the everyday user[^1] in mind: [Chrome OS](https://www.google.com/chromebook/chrome-os/). It is undeniably simple, reliable, easy to setup, and ships with several years of support before any form of EOL kicks in. New models have built-in support for the Google Play Store and Android applications, which is helpful for application development and debugging.

In addition, Chrome OS devices allow you to run Linux in a separate container alongside the main OS (on supported devices). You can't complain about that!

Let's take a quick look at other positive features worth mentioning:

- Verified boot
- Sandboxed environment (similar to how Chrome tabs work)
- Automatic updates[^2]
- *Incredible* battery life (were talking 10+ hours with heavy usage)

## My Personal Experience

A handful of months ago I snagged the Lenovo Chromebook Duet when it was on sale for my wife. Since she does all her work directly through an Android phone, I thought of this as a nice companion device. And indeed it was/is.

In that time, I played around with the tablet myself to have a better grasp of the ecosystem and it's obvious limitations. But a funny thing happened. I found that those "limitations" slowly started to disappear the longer I worked with the device.

I decided to get my own Chrome OS device and snagged the [Lenovo 10e Chromebook Tablet](https://www.lenovo.com/ca/en/laptops/lenovo/student-chromebooks/Lenovo-10e-Chromebook-Tablet/p/82AM000EUS) (on sale).

<figure>
    <img src="/public/images/lenovo-tablet.webp" alt="Lenovo 10e Tablet">
    <figcaption>Introducing the Lenovo 10e Chromebook tablet. This bad boy can do close to everything your current computer can do but it'll cost you $129...</figcaption>
</figure>


- 10.1" display (1920 x 1200) / 400 nits
- 4GB of RAM
- 32GB of eMMC storage
- Processor: MediaTek MT8183 Processor (2.00 GHz, 4 Cores, 1 MB Cache)

Now, I know that your initial reaction is likely: "Wow, those specs are pretty barebones!" and you would be correct. But it's all you need for this ecosystem to work. As cringe-inducing as it may sound, everything you plan to do on these devices should happen *in the cloud*. (Let's take a moment to avoid vomiting in our collective mouths)

Instead of using a few marketing buzz words, let me breakdown how I personally tailor Chrome OS to my needs as a designer / developer:

1. [Daily Tasks](#daily-tasks)
2. [Programming](#programming)
3. [Design](#design)
4. [Gaming](#gaming)

## Daily Tasks

I feel like going into *great* detail explaining how to do basic, daily computing tasks is a little overkill here. Spreadsheets, word documents, Zoom meetings, and streaming media work as expected. You have the ability to use Google's own web apps for these things or reach for other vendors such as Microsoft and Libre Office. Not being "locked in" to Google software is nice and I appreciate the Chrome OS team being flexible.

## Programming

This one is a mixed bag and your own mileage may vary depending on your specific requirements. Personally, I use Github for almost all my main development work. Because of this, I utilize [Codespaces](https://github.com/features/codespaces). For those unfamiliar with the service, you are running your Github repo in VSCode through the browser. It's pretty impressive.

If you happen to be a user who uses GitLab or BitBucket to store your project files, [Gitpod](https://www.gitpod.io/) is a similar product to Codespaces (which I've used on occasion). This works if your prefer.

Others may not like this programming setup but for me it works great. If running code remotely isn't your jam, you could always take a look at running [VSCodium](https://vscodium.com/) locally via Linux.

## Design

There is flexibility yet again in this category. Personally, I tend to use Figma almost exclusively as my main design tool. The best thing about Figma? It runs directly in the browser. A perfect fit for Chromebooks[^3].

I do open Gimp periodically for photo-specific work. It runs in its own Linux container and chugs along smoothly, even with 4GB of available memory. If all else fails, one could use [Photopea](https://www.photopea.com/) to keep everything working through the browser (if Linux isn't your cup of tea).

Those of you in love with MacOS specific apps like Sketch - I can't help you. You're stuck with Apple's ecosystem. (Not that there is anything wrong with Sketch!)

## Gaming

There are other options (that we will get into) but the main gaming champion here is **Stadia**[^4]. As long as your internet speeds are over 10mbps, mind you. I use garbage satellite internet (counting down the days for Starlink to become available here...) with an average speed of 18-20mbps and Stadia runs like a dream. Even *wirelessly*. Now pair this with the portability of a Chromebook device and you've got yourself a beefier Nintendo Switch.

You have solid secondary options like [GeForce Now](https://play.geforcenow.com/mall/#/layout/games) and [Microsoft's xCloud (beta)](https://www.xbox.com/en-CA/xbox-game-pass/cloud-gaming) for an even larger catalogue of games. Not to mention the ability to play a lot of Android games natively on Chromebooks that support Play Store applications.

## Eye Rolling &amp; Scoffing

I can hear the screeching across the interwebs: "*Wait - this is Google! They are literally Satan in disguise! No one can use products from that evil mega corporation!*". And while I agree with the sentiment, I think going down this pure, 100% elitist approach to software *doesn't work* with the everyday casual user. Not to mention the large swath of developers/designers screaming "Google is bad!" while working off an *Apple* device...

Hell even I, a vocal advocate for open source software and privacy, can see the great benefits to using Chrome OS as a daily driver. 

Testing out Chrome OS with your non-technical friends and family could help reduce a lot of headaches found in more "popular" systems. That doesn't mean advanced users have to switch over. Use what works the best for you. For my immediate family members and social circles, I have nothing but positive things to say about Chrome OS.

I have no crystal ball to see what the future of Chrome OS holds  but it looks pretty promising to me.

[^1]: "Users" referring to those mainly using their devices for word documents, spread sheets, media consumption, programming, messaging, minor interactivity (no heavy video or production editing)
[^2]: These updates go unnoticed, compared to that of MacOS or Windows...
[^3]: Your mileage may vary depending on how much RAM you have on your device
[^4]: Although, Stadia's current game selection leaves a lot to be desired
