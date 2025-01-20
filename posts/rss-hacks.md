# RSS Hacks With XSLT

2022-05-23

In my spare time I've been further tinkering (hopefully for the better) with my humble Shinobi Website[^1] script. The most recent update in `patch-1` came with a solid amount of QoL improvements. If you're interested, I wrote about it on the official Shinobi blog[^2].

The next feature I wanted to tackle was designing a custom layout for the XML files directly in the browser. I was greatly inspired to create something similar to Len Falken's main directory listing[^3], since that blog was one of the original inspirations for Shinobi. I'm not able to copy what's there though, since our feed builds are quite a bit different.

I then proceeded to fall down the XSLT rabbit hole.

## It Never Works the First Time, Does It?

Since the shinobi script generates valid RSS code by default, I didn't want to mess around _too_ much via XSLT and risk breaking validation. I also wanted to keep the "plain text" look-and-feel for consistency with the rest of the site, even though the XSLT template would render into standard HTML. Minor CSS styling and placing the content directly inside `pre` tags solved these issues.

My first attempt was to use the available `sort` parameter (in XSL version 1.1+) targeting the `dc:date` type linked to the `pubDate` element:


~~~html
<xsl:sort select="pubDate" data-type="dc:date" order="descending"/>
<!-- each individual post's content here -->
~~~


This did not work as intended. RSS 2.0 requires that the `pubDate` content is set to comply with the RFC-822 date-time[^4], which shinobi handles perfectly fine. The issue came from the XSL `sort` parameter not honoring this setting across all dates. My best guess is that it struggles to properly organize posts from their "month" parameter, so it sets the posts in order of date in what I refer to as "monthly sections".

If anyone knows why this failed to consistently order the posts via `pubDate`, please let me know using the comment link below. I'm far from an XSLT expert and might have overlooked something painfully obvious!

## RSS Hack: Categories

After spending far too much time reading over documentation, official manual pages and Stack Overflow comments I gave up on the `dc:date` sort. I realized I could sort the posts much easier if they were converted into a format similar to ISO 8601. But `pubDate` is required to be in RFC-822, so I couldn't alter that in the final XML file.

Then I remembered the `category` tag which shinobi does not utilize by default.

First I needed to convert the RFC-822 formatted date (found on the first line of all blog post text files) and render it inside a `category` tag. This was simple enough:


~~~sh
$(date -j -f "%a, %d %b %Y" "$(head -n 1 $file)" +"%Y/%m/%d/%u")
~~~


In a nutshell, this converts the RFC-822 date into the format "2022/05/24/2". Simple numbers that can be sorted much easier by XSL. Now all that was needed was setting to `sort` parameter properly:


~~~sh
<xsl:sort select="category" order="descending"/>
~~~


Everything worked perfectly and the RSS was still valid!

### Patch-2 Pending

I've ported these changes over to this blog to perform some "in the wild" testing. You can see the custom feed list in your supported browser by visiting:

[https://pblog.btxx.org/feed.xml](https://pblog.btxx.org/feed.xml)

As for the shinobi project itself, I have not merged these updates into the main master branch (at the time of publishing this article). They can be found sitting on patch-2[^5]. My plan is to get this merged ASAP once a little more real-world testing is finished and I can include a better "setup/install" section for newcomers.

## Shinobi Updates

If you're interested in more updates and details about the shinobi project itself, feel free to sub to that specific feed below. This post was more focused on hacking RSS parameters that happened to involve shinobi, but in the future all updates specific to the project will be posted there:

[https://shinobi.btxx.org/feed.xml](https://shinobi.btxx.org/feed.xml)

[^1]: https://shinobi.website/
[^2]: https://shinobi.website/posts/patch-1.txt
[^3]: http://len.falken.directory/
[^4]: https://validator.w3.org/feed/docs/error/InvalidRFC2822Date.html
[^5]: https://git.sr.ht/~tdarb/shinobi-script/tree/patch-2
