# The Forge Wars

2026-09-20

> No fate but what we make

Lately I've been experiencing *forge fatigue*. Most of my projects are hosted and mirrored across Codeberg, Sourcehut, and GitHub. My main issue has been trying to determine the best "home base" or deciding which one to be the *real* git forge. It's annoying. 

The problem is that some developers will shame you for using GitHub, some will disagree with Codeberg's ToS, and others will complain about Sourcehut's email-based workflow. It's impossible to make every user happy. Such is life, I guess.

So, I've decided to say "screw it" and started hosting my own `git` instance running on top of `cgit`. You can check it out here: [git.btxx.org](https://git.btxx.org)

Everything will still be mirrored across the above mentioned forges as well, but the *main* repo will be mine to control. Patches and discussions will happen on the *freelists* mailing lists, since email-based workflows are *my* preferred way to work. Maybe I will lose out on some developers who only know how to contribute through UI-based PRs[^1]. I'm willing to accept that.

My most popular projects (the 512kb & 1MB clubs mostly) have already transitioned over. But things are slow-going at the moment and my other, smaller projects have not been ported yet. I'll get to them all eventually.

## Forging Independence

This move feels good. I'm not beholden to the whims or policy changes of a third-party provider and I can freely tweak anything I wish. If I grow tired or frustrated with `cgit`, it's easy enough to switch over to `gitea` or `forgejo`. Time will tell.

I'm sure nothing I've shared here is profound or innovative. Plenty of other people host their own, independent forges. I'm just happy to have joined their ranks.

[^1]: I don't have any important open source projects anyway :P

