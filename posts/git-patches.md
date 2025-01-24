# Applying Email-Based Git Patches in Evolution on Linux

2023-04-25

Users who work with git patches through email most likely use a terminal-based program such as `aerc` or `mutt`. CLI email clients tend to have built-in support for easily applying patches directly to their local repos. But what about people who prefer to use graphical email apps?

Lucky for us, it is actually fairly simple to replicate a similar workflow to that of a CLI client. In this example I will be focusing on the Evolution email client, but the core principles should work in most other GUIs.

## The Basics

<div class="alert note">
  <span><b>Note</b> The following assumes you already have <code>git</code> installed and setup on your existing system.</span>
</div>

I find it best to first create a top-level folder on your system named `patches`. We will use this folder as a temporary location for reviewing any `git` patches submitted via email. I normally place this under `/home/<username>/patches`.

Next, locate the email patch in Evolution and right-click on it. Select "Save as mbox..." and place this file inside your newly created `patches` folder.

Now simply open your terminal, navigate to your project and run:

~~~sh
git am <path-to-patches-folder>/<patch-filename>.mbox
~~~

This should apply the patch directly to your project without issue. You are now free to test these changes locally. If everything looks good, you're able to instantly push these changes remotely.

Done and done.

Feel free to purge your `patches` folder regularly or keep them around for future reference if you prefer!