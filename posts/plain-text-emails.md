# Plain Text Emails, Please

2019-09-09

When it comes to website / product design and development most devs should try to keep things simple. By only using as much code as absolutely necessary, projects avoid growing out of scope or becoming bloated. So, why isn't this same approach taken for email?

## A brief history of email

Email has been possible since the 1960s with [time-sharing computers](https://en.wikipedia.org/wiki/Time-sharing) being used to share files and messages across early devices. Around the 80s and 90s it seemed as though [GOSIP](https://en.wikipedia.org/wiki/Government_Open_Systems_Interconnection_Profile) would dominate the market, but this was knocked out in favor of SMTP, POP3 and IMAP in 1995 when the [National Science Foundation ended its sponsorship of the Internet backbone](http://www.walthowe.com/navnet/history.html), and all traffic relied on commercial networks.

<figure>
    <img src="https://upload.wikimedia.org/wikipedia/commons/6/68/Timesharing_and_Development_KA-10s_at_BBN%2C_circa_1970.webp" alt="First computers to send and receive email" />
    <figcaption>The first computers to send and receive email. Source: <a href="https://en.wikipedia.org/wiki/File:Timesharing_and_Development_KA-10s_at_BBN,_circa_1970.webp">Wikipedia</a></figcaption>
</figure>

Things were looking pretty good at this point. Most operating systems now had a shared foundation of sending and receiving emails on the internet, allowing for a set of standards to be slowly developed and agreed upon over time. These were simpler times, with the default content sent between machines being plain text. No embedded images, no CSS3 fallback support, no *fluff* - just content.

**Sidenote:**<br>
Now, I'm not going to sit here and pretend to be some expert on the history of email (or the internet in general), so I suggest you take the time to read about [the history of the internet](http://www.walthowe.com/navnet/history.html) if you're into that kind of thing.

## Looking at some data

> Data isn't everything

I understand that the data being used is currently 16 years old - but not many extensive research studies have been performed (specifically for email-type preference in general)

In 2002[^1], [a small-set survey was run by ClickZ](https://www.clickz.com/real-world-email-client-usage-the-hard-data/47429/) was created to gauge the details of personal email data. The main data we will focus on is the user preference between HTML or plain text formats:

**Do you prefer receiving HTML or text email?**

| Response | Percentage (%) |
|---|---|
| HTML | 41.95 |
| Plain Text | 31.52 |
| No Preference | 26.53 |

On initial review, one could make the argument that the general public *prefers* HTML email over plain text (~42% vs ~32%) - but I would disagree with this analysis. The roughly 27% of respondents who answered with *No Preference* should not be dismissed so easily.

Since the *No Preference* respondents don't care whether emails they receive are designed in HTML format, why not send them plain text variations by default? The positives of plain text greatly outweigh those of HTML:

- Plain text has reduced file size
  - Don't forget that many users have limited data usage across much of the world
- HTML is more likely to be flagged as spam by email clients
  - This is due to extra code, tracking scripts, 3rd party assets / resources being called
- HTML / CSS can be inconsistent or even limited in support across email clients
- Text only requires less design work for your development team
  - Don't forget about testing all the various email clients too

Add to this [that 53% of emails are opened on mobile](https://litmus.com/blog/53-of-emails-opened-on-mobile-outlook-opens-decrease-33) - so any "fancy" marketing email designs need to look great on mobile screens and also take into account slower connections. What looks better and loads faster than simple plain text? 😛

## But what about marketing!?

Sorry to say, but marketing should never trump user experience. Teams love to track email opens / click ratios, who subscribed / unsubscribed or who shared the campaign with others - but **it's all bloat on the user's end**.

Greg Kogan wrote up a great article / case study about his experience [switching over a client's campaign from HTML templates to plain text](https://www.gkogan.co/blog/dont-design-emails/) with some really interesting results. I highly recommend you give it a read for a better understanding about how the marketing goals and customer goals don't always align.

## Simple or lazy - it doesn't matter

Plain text can certainly have a reputation for looking lazy or cheap, but I feel this is mostly perpetuated in the design and marketing communities. I can assure you that your average day-to-day users are much less opinionated about your email campaign design than you are. Look to satisfy your customers' needs before your own.

> Life is really simple, but we insist on making it complicated.
>
> **Confucius**

That being said, at the end of the day, companies will justify their own reasons to use HTML email templates over plain text. You can't convince everyone. My own personal experience with email template design, along with analyzing some of the data, leaves me to believe that most businesses should default to plain text. At the very least, you should try to convince your team to perform some simple A/B testing with your next email campaign.

The results might just surprise you.

[^1]: This is the "latest" detailed survey I could find on email design preference
