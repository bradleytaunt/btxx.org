# Thoughts on Technological Purity

2025-12-12

"Everything should be running on OpenBSD. My desktop, router, web server, and even minor local services should *all* be built on top of the great Pufferfish BSD."

I told myself this "mantra" not too long ago, after diving head-first into the wonderful world of BSDs. The reasoning for this was to become well-versed in a single operating system, instead of only generally understanding a handful of systems at a top-level.  And in that time I managed to use OpenBSD as [my main workstation](/posts/openbsd-gnome/), [my firewall / router](/posts/openbsd-router/), and [my personal web server](/posts/openbsd-linveo/). I had fulfilled my goal of achieving software purity (or what I *thought* was purity).

And it was pretty great - initially. Overtime small annoyances began to pop up. Mostly with my workstation. Certain applications were not available, I (begrudgingly) needed to use proprietary software, and my development workflows seemed slower than that on MacOS. Death by a thousand cuts, in a way. So I bailed on the original mantra.

I slowly started moving over some of my devices piece-by-piece. Since I use an iPhone, returning to the M2 MacBook Air (which still is an incredible feat of hardware/software design) for my personal computing device just made sense. Apple is *far* from a perfect company, but their ecosystem between iOS and macOS is objectively solid.

My website and projects were moved away from my OpenBSD VPS back over to NearlyFreeSpeech. I explain the main reasoning for this in my other post: [What Happens After I'm Gone? The Future of the Online Me](/posts/planning-ahead), if you're interested. In a nutshell, ease-of-use, future-proofing my online presence (as much as one can) and better productivity won out.

The OpenBSD router setup for my local network was initially switched over to OpenWRT paired with a Raspberry Pi Zero running Pihole. After a month or so of testing, I found the original, CLI-based BSD setup to be more performant and predictable. So I did return to using the original OpenBSD mini-PC router. (Hooray for an OpenBSD win!)

Not long after, I was in a weird state where **almost none** of my hardware or services were using OpenBSD. Which felt *wrong* in a way, as though I betrayed some kind of sacred ideal. One that I imposed on myself. Some services were still operating on open source software, but I felt like a sellout all the same.

For reference, after departing from the world of "pure" OpenBSD, my current setup is now as follows:

- macOS as my personal workstation
	- (I do still have an X201 running OpenBSD for testing)
- FreeBSD (indirectly, since it was shared hosting) for my web servers
- NetBSD for small microservices on a tiny VPS (early testing stages)
- OpenBSD running as my home router

And everything works just *fine*. I'm productive and the switch hasn't created any major hiccups with my workflows. And in a way everything is still running on BSD since macOS is built on top of Darwin, right? (I might just be trying to cope here...)

But there is a nagging in the back of my mind. I miss the simplicity of doing things on *only* OpenBSD. I miss the consistency across all my services and devices. It seems as though my "techie" subconscious just can't let this "single OS" concept go. I *can* have everything running off this single operating system but if it makes me less productive and less efficient, why force it? I need to stop looking at things as "all or nothing". It just creates self-imposed limitations.

## Stating the Obvious

I'm not claiming anything new by saying "Just use what works". Plenty of developers do this everyday without issue. My core problem is overthinking the issue. 

I guess I'm rambling more about my own internal conflict on the matter, and sharing it in hopes of resonating with others who feel the same. If you *do* feel the same, I would suggest trying your best to move on from it. Or at least keeping an open mind. That's what I've been trying. The slight nagging is still there, but I've come to understand it's based more on gut-feeling than practical logic.

Using open source software (as much as possible) is still important to me. But I'm no longer treating it like a personal dogma.


