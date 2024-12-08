# Build and Deploy Websites Automatically with Git

2024-09-20

I recently began the process of setting up my self-hosted[^1] `cgit` server as my main code forge. Updating repos via [cgit on NearlyFreeSpeech](/wiki/cgit/) on its own has been simple enough, but it lacked the "wow-factor" of having some sort of automated build process. I looked into a bunch of different tools that I could add to my workflow and automate deploying changes. The problem was they all seemed to be fairly bloated or overly complex for my needs.

Then I realized I could simply use `post-receive` hooks which were already built-in to `git`! You can't get more simple than that...

So I thought it would be best to document my full process. These notes are more for my future self when I inevitably forget this, but hopefully others can benefit from it!

## Before We Begin

This "tutorial" assumes that you already have a `git` server setup. It shouldn't matter what kind of forge you're using, so long as you have access to the `hooks/` directory and have the ability to write a custom `post-receive` script.

For my purposes I will be running standard `git` via the web through `cgit`, hosted on NearlyFreeSpeech (FreeBSD based).

## Overview

Here is a quick rundown of what we plan to do:

* Write a custom `post-receive` script in the repo of our choice
* Build and deploy our project when a remote push to `master` is made

Nothing crazy. Once you get the hang of things it's really simple.

## Prepping Our Servers

Before we get into the nitty-gritty, there are a few items we need to take care of first:

1. Your main `git` repo needs `ssh` access to your web hosting (deploy) server. Make sure to add your public key and run a connection test first (before running the `post-receive` hook) in order to approve the "fingerprinting".
2. You will need to `git clone` your main `git` repo in a private/admin area of your deploy server. In the examples below, mine is cloned under `/home/private/_deploys`

**Once you do both of those tasks**, continue with the rest of the article!

## The post-receive Script

I will be using my own personal website as the main project for this example. My site is built with [wruby](https://git.btxx.org/wruby), so the build instructions are specific to that generator. If you use Jekyll or something similar, you will need to tweak those commands for your own purposes.

Head into your main `git` repo (*not* the cloned one on your deploy server), navigate under the `hooks/` directory and create a new file named `post-receive` containing the following:

~~~bash
#!/bin/bash

# Get the branch that was pushed
while read oldrev newrev ref
do
    branch=$(echo $ref | cut -d/ -f3)
    if [ "$branch" == "master" ]; then

        echo "Deploying..."

        # Build on the remote server
        ssh user@deployserver.net << EOF
            set -e  # Stop on any error
            cd /home/private/_deploys/btxx.org
            git pull origin master
            gem install 'kramdown:2.4.0' 'rss:0.3.0'
            make build
            rsync -a build/* ~/public/btxx.org/
EOF

        echo "Build synced to the deployment server."
        echo "Deployment complete."
    fi
done
~~~

Let's break everything down.

First we check if the branch being pushed to the remote server is `master`. Only if this is true do we proceed. (Feel free to change this if you prefer something like `production` or `deploy`)

~~~bash
if [ "$branch" == "master" ]; then
~~~

Then we `ssh` into the server (ie. `deployserver.net`) which will perform the build commands and also host these built files.

~~~bash
ssh user@deployserver.net << EOF
~~~

Setting `set -e` ensures that the script stops if any errors are triggered.

~~~bash
set -e  # Stop on any error
~~~

Next, we navigate into the previously mentioned "private" directory, pull the latest changes from `master`, and run the required build commands (in this case installing gems and running `make build`)

~~~bash
cd /home/private/_deploys/btxx.org
git pull origin master
gem install 'kramdown:2.4.0' 'rss:0.3.0'
make build
~~~

Finally, `rsync` is run to copy just the build directory to our public-facing site directory.

~~~bash
rsync -a build/* ~/public/btxx.org/
~~~

With that saved and finished, be sure to give this file proper permissions:

~~~bash
chmod +x post-receive
~~~

That's all there is to it!

## Time to Test!

Now make changes to your main `git` project and push those up into `master`. You should see the `post-receive` commands printing out into your terminal successfully. Now check out your website to see the changes. Good stuff.

## Still Using sourcehut

My go-to code forge was previously handled through sourcehut, which will now be used for mirroring my repos and handling mailing lists (since I don't feel like hosting something like that myself - yet!). This switch over was nothing against sourcehut itself but more of a "I want to control all aspects of my projects" mentality.

I hope this was helpful and please feel free to reach out with suggestions or improvements!

[^1]: By self-hosted I mean a NearlyFreeSpeech instance