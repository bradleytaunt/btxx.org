# Git Your Freedom Back: A Beginner's Guide to SourceHut

2025-01-24

This article (or guide) is targeted towards users and contributors who are currently hosting their git repositories through GitHub. The goal of this post is to convince developers to move away from GitHub altogether. I will breakdown GitHub's most popular core features and provide details on SourceHut's alternative approach for each of them. Hopefully by the end of this guide developers will try SourceHut or at the very least, begin to question *why* they are still using GitHub.

<div class="alert note">
  <span><b>Note</b> Obviously the most "secure and free" solution would be hosting your own git server. Self-hosting is a great idea and you should do so if you have the means. That being said, this article is focused on SourceHut since most users do not have the time to manage both their projects <i>and</i> maintain a self-hosted instance.</span>
</div>

## Before We Begin
{:.no_toc}

It is important to make this clear: I am in *no way* affiliated with SourceHut, nor have I been approached to write this guide. I'm simply a happy SourceHut user who wants to see the community thrive!

You'll also need to approach this guide with an open-mind. If you start off angry or feel like this is an attack on you for using (and maybe even enjoying!) GitHub, then you should come back once you're in a better *headspace*. This is merely a detailed guide on how to achieve a solid set of feature parity between GitHub and SourceHut.

Alright, enough talk. Let's get into it!

* toc
{:toc}

## Why GitHub Isn't Great

### 1. Microsoft Ownership and Data Privacy

GitHub is owned by Microsoft, a company known for aggressive data collection practices. This should raise concerns to most developers about their privacy and how it's handled.[^1]

SourceHut's policy on information and privacy:

> Aside from information you choose to make public in the course of your use of sr.ht and information you explicitly choose to share with specific third parties, none of your information is shared with third parties [Source](https://man.sr.ht/privacy.md#how-we-share-your-information-with-third-parties)

### 2. Telemetry and Tracking

GitHub tracks user behavior through telemetry data, including interactions on the platform. Not to mention, the default Visual Studio Code application sends additional telemetry (unless developers opt to use the "open source" variation).

SourceHut's data collection and tracking policy:

> The only data we require of your account is your email address; a username of your choosing, which must be unique among all users; and a password. [Source](https://man.sr.ht/privacy.md#what-we-collect-and-why)

Not to mention, that's only if you create an account. Contributing to existing projects only requires an email. (You will see this point come up a few times through this article)

Also, directly on the homepage of [sourcehut.org](https://sourcehut.org):

> Absolutely no tracking or advertising

### 3. Proprietary Nature

GitHub is a proprietary platform, limiting user control over their data and infrastructure compared to self-hosted or open-source alternatives. If you can't see it - you shouldn't trust it.[^2]

Also, features like GitHub Actions, Copilot, and Codespaces create vendor lock-in, making it harder for users to migrate to alternatives. (Hence the existence of this article)

### 4. Copilot and Code Scraping

The **BIG** one. GitHub Copilot uses publicly available code repositories to train its AI. This raises a lot of concerns about copyright infringement and unauthorized use of user content. Additionally, having Copilot default as an opt-out feature is very shady.[^3] [^4]

Yet again on the homepage of [sourcehut.org](https://sourcehut.org):

> No AI features whatsoever

### 5. Geopolitical Censorship

GitHub has complied with government requests for content takedowns and blocked users in certain countries (e.g., Iran, Syria) due to U.S. trade sanctions.

SourceHut is moving its entity out of the US, and will be solely set within the European Union:

> We are in the process of moving SourceHut to the European Union, and have incorporated in the Netherlands. Consequently, the terms have been updated to clarify that users are required to comply with Dutch law in addition to US law. The requirement to comply with US law will be removed in a future update after we close the US entity. [Source](https://sourcehut.org/blog/2022-10-31-tos-update-cryptocurrency/)

### 6. Centralization Risk

GitHub represents a centralization of the open-source ecosystem, which goes against the decentralized ethos of open-source software. This feels at odds with those publishing *open source projects* on a closed platform...

Contributors are also required to have GitHub account, creating friction and spawning more vendor lock-in. SourceHut only requires you to have a working email to contribute to projects. You don't even need an account!

### 7. Lack of Transparency

GitHub's decision-making processes, especially regarding policy changes and feature implementations, lack sufficient community involvement and transparency. It's difficult to trust or depend on policies that can change at any time without notice given to the community.

### 8. Gamification

GitHub is built with the sole purpose to drive engagement. This even takes priority over distributing and promoting quality software. It's more of a social media network with a git forge slapped on top.

SourceHut has no "star" system or incentive to chase "likes". No recommended projects or *trending* feeds. If you're looking to promote or gain contributors to your project, working through a "gamed" system is not the best approach long term.

## GitHub's Core Features

The full feature set for GitHub is larger than what I've selected below, but we will focus on the most popular:

- Issues (Tickets)
- Pull Requests
- Actions
- Pages
- Wiki

## SourceHut's Alternatives

### Pull Requests &rarr; Patches

This is the meat and potatoes of the GitHub platform. It's probably the *core reason* developers choose GitHub as their main git forge. I get it. It does have it's advantages of giving a better experience for reviewing a set of changes. Initially. But what if I told you there was a time when submitting email-based *patches* was the standard for version control?

Reviewing, submitting, altering, and accepting git email patches is *not* difficult at all. If a simpleton like myself can handle it, then seasoned developers should have zero issues. Best of all, SourceHut includes its own visual interface to help you when working with patchsets:

<figure>
  <img src="/public/images/sourcehut-patches-list.webp" alt="SourceHut's patch list view">
  <figcaption>The patches view for my <a href="https://lists.sr.ht/~bt/1mb-club-devel/patches">1MB Club project</a>. Very clean.</figcaption>
</figure>

Testing the changes locally is easy. The sidebar UI gives you all the instructions you need. The screenshot below shows how SourceHut lets you:

1. Export the patchset directly via `mbox` (I have an [article for working with git patches in Apple Mail](/posts/mail/), if that's your thing)
2. Import the patchset into your project via CLI (comes with helpful reference to [git-send-email.io](https://git-send-email.io/))
3. Reply to the thread (this refers to the mailing list, but you can think of this as PR discussions)
4. Update the status of the patch (ie, PROPOSED, APPLIED, etc.)

<figure>
  <img src="/public/images/sourcehut-patches-export.webp" alt="SourceHut's patch sidebar actions UI">
  <figcaption>SourceHut provides very simple instructions for testing, reviewing, and approving patches locally.</figcaption>
</figure>

So don't let anyone tell you there is "no user interface" for dealing with contributions. It simply isn't true.

### Issues &rarr; TODOs

Issue tracking in SourceHut is on par (if not better!) than GitHub's. The biggest difference most users will notice right away is having a *functional* search. How GitHub has continuously fumbled with this aspect is baffling. Maybe it has to do with so much added bloat, but jumping around tickets or searching for specific terms feels sluggish in GitHub. Performing those same actions in SourceHut feels incredibly snappy.

<figure>
  <img src="/public/images/sourcehut-issues.webp" alt="SourceHut's TODOs UI.">
  <figcaption>SourceHut's take on "issues". Keeping with that <i>clean</i> interface concept.</figcaption>
</figure>

Take note of the `submit via email` action in the above screenshot. This allows developers to contribute to your project *without needing an account*. That opens up your projects to a much wider pool of talent and avoids privacy concerns that more security-focused individuals might have.

SourceHut also includes `labels`, similar to that of GitHub. You can make sets of labels and view their associated tickets directly in the creation UI page (or search via the filter term):

<figure>
  <img src="/public/images/sourcehut-add-labels.webp" alt="Adding labels for use with SourceHut TODOs.">
  <figcaption>Adding labels in SourceHut is very similar to GitHub.</figcaption>
</figure>

### Actions &rarr; Builds

Both platforms let users automate tasks like running tests, building projects, and deploying code using workflows. For GitHub these are set under "Actions", where SourceHut refers to them as "Builds". Actions are defined under `.github/workflows/`, while Builds are set at the root directory. Both use `.yml` files for configuration.

More feature parity at a glance:

- Both systems define workflows as a series of jobs that can run sequentially or in parallel, depending on the configuration
- Both allow users to specify their environments / architecture
- Both platforms allow the use of environment variables and secrets for secure access to sensitive data like API keys and credentials during builds
- Both systems support triggers for workflows:
  - Pushes to branches
  - Pull requests/merge requests
  - Scheduled events (cron jobs)
  - Manual triggers

Although GitHub Actions comes with a more "visual" option for those who prefer using a web interface, the basic structure of a SourceHut `.build.yml` file is pretty straightforward. Here is an example of building out a basic Jekyll site and deploying it directly to SourceHut Pages (which we will get to shortly!):

~~~sh
image: alpine/latest
oauth: pages.sr.ht/PAGES:RW
packages:
- go
- hut
- ruby-full
- ruby-dev
environment:
site: 1kb.club
sources:
- https://git.sr.ht/~bt/1kb-club
tasks:
- install-bundler: |
    sudo gem install bundler
- build: |
    cd 1kb-club
    sudo bundle install
    sudo bundle exec jekyll build
- package: |
    cd 1kb-club/_site
    tar -cvz . > ../../site.tar.gz
- upload: |
    hut pages publish -d 1kb.club site.tar.gz
~~~

It is easy to read and digest what each section of the build config is doing. You can create much more complex configurations as well. I suggest reading through the [official builds docs](https://man.sr.ht/builds.sr.ht/) and  taking it for a test drive!

### Pages &rarr; Pages

There really isn't much to say in this section. Both GitHub and SourceHut provide easy to use "static" web hosting. Taking some info directly from the [SourceHut Pages website](https://srht.site):

- Any content generator, including Jekyll, Hugo, Doxygen, or your cool new one
- Automatic, zero-config TLS
- Use our domain or BYOD

It's incredibly quick to get up-and-running with a website on SourceHut. Pairing it alongside the previously mentioned "Builds", you can have an automated deployment configured in under 5 minutes. Again, the [official docs](https://srht.site) are your friend.

### Wiki &rarr; Man (Wiki)

The unfortunate thing about GitHub, is the lack of developers including Wikis or proper documentation for their larger projects. Because of this, I doubt there are many devs who *require* a good wiki-workflow. For those of you who do - SourceHut wiki pages are great. Like everything else under the `sr.ht` brand, things are kept just simple enough without losing too much core functionality you'd expect.

<figure>
  <img src="/public/images/sourcehut-wiki.webp" alt="Default wiki page view on SourceHut">
  <figcaption>A wiki page on SourceHut. Gives off Linux manpage vibes...</figcaption>
</figure>

The fact that wikis are managed at a top level under `man.sr.ht` is quite nice as well. With GitHub you need to find your desired repo, then jump into the wiki section pages. SourceHut lets you view a "master" view of all existing wikis, spanning across any number of repos. 

Any UX tweak that saves time is a win for me.

## Cost

GitHub is indeed "free". I place that word in quotes because what isn't taken from your wallet, is taken elsewhere. Your personal information, data of your usage of their products and public code is the true *cost* to use GitHub. So, what does SourceHut cost?

|Tier|Cost|
|----|----|
|Amateur|$2/month or $20/year|
|Typical|$5/month or $50/year|
|Professional|$10/month or $100/year|

You can also earn free service under certain financial situations or by contributing to the SourceHut project directly:

> If you require financial aid to use sourcehut, please send an email explaining your circumstances and we'll do our best to accommodate your needs.
> 
> Sourcehut is itself an open-source project. Users who contribute patches to the upstream project are eligible for free service. [Source](https://sourcehut.org/pricing/) 

And if none of that sounds appealing to you - you can *host your own SourceHut*! Just for comparison, can you host your own one-to-one copy of GitHub?...

## Why Not Use...?

I am aware that there are many other git "forge" platforms available. [Gitea](https://about.gitea.com), [Codeberg](https://codeberg.org), and [Forgejo](https://forgejo.org) all come to mind. Those platforms are great as well. If you prefer those options instead of SourceHut that's fine! Switching to any of those would still be a massive improvement over GitHub.

Unfortunately, I find the need to have an account in order to contribute to projects a deal breaker. It causes too much friction for no real gain. Email based workflows will always reign supreme. It's the OG of code contributions.

<div class="alert note">
  <span><b>OpenBSD Fans:</b> Keep an eye out for the upcoming <a href="https://opencollective.com/gothub">gothub</a> (Game of Trees Hub). That project could be a great place for those interested in trying out the OpenBSD specific <code>git</code> alternative: <code>got</code>.</span>
</div>

## Try It

If you've made it this far, why not give it a try? Maybe start by keeping a remote copy of your existing GitHub projects on SourceHut. Give your users and contributors the option to work with either platform. After some time, I truly think you'll prefer the way `sr.ht` does things and eventually leave GitHub behind. 

That's what happened to *me*.

## Contribute

This article might not be 100% perfect. Nothing in life is. If you see a mistake or notice I've overlooked something, [please submit a patch on SourceHut](https://git.sr.ht/~bt/btxx.org/).

<small>Oh, a SourceHut link... how meta!</small>

[^1]: [en.wikipedia.org/wiki/Criticism_of_Microsoft](https://en.wikipedia.org/wiki/Criticism_of_Microsoft)
[^2]: [lists.gnu.org](https://lists.gnu.org/archive/html/discuss-gnustep/2015-12/msg00168.html)
[^3]: [theregister.com](https://www.theregister.com/2023/06/09/github_copilot_lawsuit/)
[^4]: [github.com/orgs/community/discussions/7163](https://github.com/orgs/community/discussions/7163)
