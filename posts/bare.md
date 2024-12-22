# Deliver the Bare Minimum

2024-12-22

I'm a minimalist at heart, so keeping things as simple as possible tends to be my *thing*. I love tinkering with an idea or product feature while trying to reduce my reliance on dependencies or purposely constraining personally set limits (maybe this is bandwidth, resource usage, etc.). I almost prefer ugly "hacks" in favour of something *slightly* less performant, just to win the tiniest of savings. It's silly, but my brain won't let me escape it. This doesn't mean it's always the "correct" way to approach both design and development, but it's what works best for me. 

An issue I tend to see in my travels through the world of software engineering is over-engineering. Shocking, I know. I'm not the first developer to point this out, nor will I be the last. Even still, I believe it deserves being repeated as often as possible. An unoriginal mantra of mine is: 

> Keep things as simple as you reasonably can. 

Notice the word: "reasonably". This is important because simplifying any software task shouldn't be taken as a blanket statement. Sometimes your hands are tied. That's fine.

But in most situations you should only deliver the *bare minimum*.

## Hypothetical Examples

Everyone loves hypothetical, right? So here's one:

Jim is an engineer and works for "THE COMPANY". A client has requested a JSON file that contains all recent, Canadian buyers of their "PRODUCT ABC". Jim can handle this task no problem, but thinks it is a little short-sighted. Jim thinks to himself, "What if they want to check buyers from the US? What if they want a shorter or longer time frame?". So, Jim starts to build a *richer* experience for the user. He creates a private front-end UI, that gives the client the ability to select country, time-frame, along with buying / selling options, which can then be exported as JSON directly from the browser. It looks great and works flawlessly. Well done, Jim!

In the above example, Jim didn't do anything *horrible* per se, but he certainly wasted both his own time and the client's. Even if the client is "wowed" by this front-end, Jim has actually created more problems for himself. He now has to *maintain* that front-end. The client might even expect or request additional functionality to that new UI. Jim also could have been handling other prioritized tasks, reviewing code or helping teammates with that reduced bandwidth. Jim should have simply exported the requested JSON data and handed it over.

This whole concept might sound incredibly trivial, but you have no idea how often something like this occurs in software development. Maybe devs are just trying to impress their superiors and coworkers or maybe they're just trying to stimulate themselves. Whatever the reason, 99% of the time I would say it is a bad decision.

It's back to that mantra: *Keep things as simple as you reasonably can.*

## Happy Accidents

I think the legendary Bob Ross said it best:

> Just remember that you can always add more, but you can’t take it away.

He was talking about layering colors while painting, which in certainly more permanent than most software, but it still works wonderfully to guide us as developers. Tackle each task as you go, don't increase your own overhead unless it is agreed upon by all parties involved. Impress those around you by keeping things at their *bare minimum*.

![Bob Ross painting a picture](/public/images/bob-ross.webp)

"The least little bit can do so much."
