# New Domain and Code Forge

2024-01-29

As you can clearly see, my site's domain has switched over to **btxx.org**. This post will go into details about the reason for this URL swap (spoilers: I'm a cheapskate) - but that isn't all. I have moved my personal git repositories over to my own hosting. I will explain the reasoning for that switch as well.

But enough introductions, let's get into it!

## bt.ht is No More

I've abandoned `bt.ht`. Well, kind of. That domain doesn't expire until 2025, which works out nicely since I can keep a complete web forward active for the entire year. This will avoid such a radical switch, similar to what I did years ago with my "uglyduck" domain[^1]. Hopefully anyone who follows my dumb ramblings will have more than enough time to become familiar with the new URL.

For reference, those interested in updating their RSS will need to use the latest URLs:

- [RSS](https://btxx.org/index.rss)
- [Atom](https://btxx.org/index.atom)

You have roughly a year to do so, since new posts should still automatically appear even with defaulting to the older URL (hooray for 301 redirects!).

There were two core reasons for switching domains. The first was based off a change in ownership with my previous domain registrar, Gandi. You can read more details [here](https://news.ycombinator.com/item?id=35080777), but they were essentially bought out, then decided to cancel their free email service and raised their prices. Not many registrars support the `.ht` TLD, so moving to another provider was already proving to be difficult. Once my mind was made up that I didn't want to support such shady actions from a company, I thought even more about the concept of spending *so much* on a domain name in the first place. It was a novelty to have such a "short" domain, but that seems silly in hindsight.

Just take a look at the differences in domain costs and email services below:

|URL|Domain/year|Email/year|Total|
|---|-----------|----------|-----|
|bt.ht|$172|$60|$232|
|btxx.org|$17|$19|$36|

By making this switch (for both my domain and email service) I would save a yearly total of **$196 USD**. This was a no-brainer. The minute I did the math I thought, "Hell, I'm already moving everything to a different registrar *and* I need to look for a separate email provider...why not just start fresh with a new, *cheaper* domain?"

So that's what I've done.

## My Own Code Forge

As some people in the open source community might already be aware, [sourcehut](https://sourcehut.org) had a major outage a couple weeks back. It lasted a few days and all services were impacted. This meant that all publicly hosted websites, build processes and `git` repositories were unavailable. It was no fault of sourcehut of course, they were viciously attacked for no *real* reason.

But this outage did get me thinking about what it means to "control" my own code. I always liked the idea of hosting my own git projects but relied on third-party services since they were more convenient. The problem with entrusting anything, not just code storage, to third-party services is lack of oversight. You really have no idea what is happening behind the scenes. You don't control your own backups. You don't have the freedom to tweak UI or user flow of your project views (which I understand is certainly an edge-case).

These thoughts lead me to research some "self-hosted" code forge options. My main contenders were:

- GitWeb
- cgit
- Gitea

I'll save you the suspense: I went with cgit. Getting GitWeb configured properly was giving me a lot of issues and Gitea seemed overkill for my person needs. I host through NearlyFreeSpeech (running FreeBSD) and they had a decent tutorial for setting cgit up on their servers. I've updated my own wiki for those interested in doing something similar: [read the full step-by-step instructions for setting up cgit](/wiki/cgit).

I still need to go through most of the existing projects on sourcehut and update their READMEs and purge the contents. The last thing I want to do is have users confused about which repo is the "real" one.

For reference the my repos are now located here: [git.btxx.org](https://git.btxx.org)

(I plan to place this in the main navigation soon...)

## Mirror, Mirror on the Wall...

I'm aware that to have extra protection from "downtime" that I should also mirror my code on separate forges. I plan to do this sometime in the future, but this isn't a major priority for me currently. When the time comes I'll be sure to update my repos referring to the mirrors (whatever platform that is I choose).

## Room for Improvement

My code forge is far from perfect. Mobile view is lacking, there is no dark mode support and things could be slightly more intuitive. But I love it. The beauty of hosting everything on my own is that I can improve these things myself. For now, I'm happy with the outcome!


[^1]: Someone oddly picked up that domain and piggybacked off the back-links. They happen to also be a designer...Guess the naming was that cool?
