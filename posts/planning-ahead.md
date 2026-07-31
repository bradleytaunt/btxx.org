# What Happens After I'm Gone? The Future of the Online Me

2025-09-12

Well, that's a morbid headline...

Let me start off by saying that I am doing well and in good health! This post is focused more on the concept of "future-proofing" my open source projects and stupid little mini-sites once I am no longer around to keep the wheels turning, so to speak. It's something that most of us probably don't think about. That makes sense, since it isn't the most joyful thing to focus on. But it does impact our individual "homes" on the internet, no matter how small.

So, I decided to write-up my *current* online fail-safes, along with my plans for keeping most things running smoothly after I'm gone.

* toc
{:toc}

## The Internet is Not Important

Let's get this out of the way first. The internet doesn't matter compared to *real-life*. Obviously if all my projects / sites disappeared from the web tomorrow it wouldn't be a big deal *at all*. Family, friends, and those directly impacting your life should always take precedence over online communities (even if those communities are awesome!). Before you consider wasting any effort future-proofing your online "stuff", take the time to **write up a will**. It's worth the cost (heck, even online services exist for this now) and once complete it will allow you to focus on more stupid things, like your online stuff!

If you takeaway one thing from the post, it should be to get yourself a will.

With that out of the way, let's move on to the less important things in life!

## Services

### Domains and Web Hosting

I believe most domain owners and web masters don't think much about their custom domains or hosting that often. I mean, they *think* about them but not how to handle their management once they, as the sole owners, pass on. If you own any domains or use some form of web hosting, ask yourself the following:

* Is auto-renew setup? If so, will the payment source ever fail / expire?
* Are notifications setup? If so, will anyone else have access to these?
* Is there an emergency contact?
* Are there any advanced settings (DNS, forwarding, etc.) that should be documented somewhere?
* Shared login details?
* What happens if the current company shutters? Is there a migration plan?

Domains are critical for long-running projects or even personal sites that represent you as a person. You don't want renewals to lapse and have your domains scooped up by online scalpers. They could hold the domain hostage or possibly use it for nefarious purposes (sending out malicious content or collecting user data).

As for hosting, the web moves fast and you can't assume anything will last forever. What you *can* do is place your bets on providers that have predictable longevity. The two hosting providers I always recommend are [NearlyFreeSpeech.NET](https://nearlyfreespeech.net) (NFSN) and [RamHost](https://ramhost.us) VPS. NFSN is more inline with your standard "shared hosting" setup, where RamHost is a VPS with full root access.

Reasons why I like **NFSN**:

* Allows for [direct, outside contributions](https://faq.nearlyfreespeech.net/section/ourservice/donations) to your account
	* This is extremely helpful to keep the balance "topped up" while waiting for an account transfer / takeover
* Aligns well with free speech core values (vital for an open web)
* Online since 2002
* Great community, helpful members in the forums
* Optional paid support (I've never needed, but nice to have)
* No bullshit UI, gets out of your way
* Bonus: runs on FreeBSD

Even **jdw** (founder/owner of NFSN) has previously talked about the [bus factor](https://en.wikipedia.org/wiki/Bus_factor) in the [members forum](https://members.nearlyfreespeech.net/forums/viewtopic.php?t=11627) (2024), in which he responds to talk of retirement:

> Not to worry, you've got a good 20 years before that's a remotely realistic possibility.

That's solid enough for me.

Reasons why I like **RamHost**:

* Supports OpenBSD (and many others)
* Online since 2009
* No bullshit UI, gets out of your way
* Costs just [$15/year](https://tinykvm.com) for 512 MB RAM / 10 GB Storage / 500 GB Traffic

The only downside is that there is no direct "contributions" funding for your account. Fortunately, you can add multiple points of contact that can be notified about upcoming renewals. Their support is quite good as well, so I would be hopeful they would provide assistance for non-techy individuals taking over an existing account.

I use RamHost for just a few of my projects and mini-sites that need to be running on top of OpenBSD. For most people, NFSN would be the easier option.

### Email

This one is a little more difficult. From my research I have yet to find an email provider which allows for a similar "account contribution" setup similar to that of NFSN. You *could* fallback back to a "free" service like Gmail, and utilize NFSN's [email forwarding service](https://www.nearlyfreespeech.net/services/email). But Gmail is pretty terrible (for many reasons).

It seems the best option is to simply provide your executor with direct login access to your email registrar. Some providers I recommend are:

- Migadu
- Tutanota
- Proton
- Mailbox.org

### Social

I myself don't have many "social" accounts online, but most people do. There isn't much of a *plan* for continuing to interact with social network communities, nor should there be since that would be creepy. The best practice would be to simply notify online friends and followers about what happened, along with plans to eventually shutdown these accounts.

### Passwords

All of these above services *should* have their own secure logins. Expecting loved ones to memorize all of your individual passwords is a lot to ask, so it makes sense to utilize a password manager. Any will do (Bitwarden, 1Password, `pass`) just so long as the master password is handed over to the one in charge of the "digital you" after you're gone. That will make things much easier when tackling items such as web hosting and domain configuration.

It's important to note that some logins require, or were maybe were setup with, authentication services. Make sure access to these authentication codes is provided as well for those taking over.

## Open Source Projects

Most open source projects that provide any form of public access or version controlling should be fairly future-proof by default. If you self-host a git forge, just be sure to have at least one mirror of you projects on a public git service. I personally recommend [Codeberg](https://codeberg.org). That way, anyone can fork and tweak and re-share your awesome work.[^1]

## End on a Happy Note

I apologize if this post made you more aware of your own mortality - that was not my intention! At the end of the day, online *stuff* doesn't really matter and you don't need to preserve anything if you don't feel like it. I just think it would be nice to keep your online lights on when all other lights go out.[^2]

Life is wonderful and you should enjoy every moment of it!

[^1]: So long as the licensing allows it...
[^2]: Yes, this is a Lord of the Rings quote. No, I'm not sorry.


