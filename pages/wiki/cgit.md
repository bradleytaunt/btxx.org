# cgit

This page contains a comprehensive guide to setting up cgit on NearlyFreeSpeech. 

**Important**: It is assumed that you already have an account with NFS and also have access to a "site" online.

Most of the following has been lifted from [NearlyFreeSpeech cgit application walkthrough](https://members.nearlyfreespeech.net/wiki/Applications/Cgit) but has been tweaked and updated.

## Setup `git` Repostories

The first thing we need to do is setting up our `git` repos, with the ability for the public to clone our projects. Each one of your project repos will need to follow this same procedure. 

Make sure to change your "domain" folder accordingly.

~~~sh
cd /home/public/git.btxx.org

mkdir myproject.git
cd myproject.git

git init --bare

# Configure for HTTP access
git config http.getanyfile true
git config http.uploadpack true

# Update server info (crucial for HTTP cloning)
git update-server-info

# Set up the post-update hook
cat > hooks/post-update << 'EOF'
#!/bin/sh
exec git update-server-info
EOF

chmod +x hooks/post-update
~~~

Then make sure to include the following `.htaccess` file at the root of your domain folder (ie. `git.btxx.org/`):

~~~sh
SetEnv GIT_PROJECT_ROOT /home/public/git.btxx.org
SetEnv GIT_HTTP_EXPORT_ALL
~~~

Now you can test this locally by running:

~~~
git clone https://git.btxx.org/myproject.git
~~~

## Building cgit

The following assumes that you wish to have cgit running at the top-level of your chosen domain (ie. git.example.com)

SSH into your account then download and unpack the latest release:

    git clone git://git.zx2c4.com/cgit cgit-src
    cd cgit-src

Create a cgit.conf file with desired locations:

    CGIT_SCRIPT_PATH = /home/public
    CGIT_DATA_PATH = $(CGIT_SCRIPT_PATH)
    CGIT_CONFIG = $(CGIT_SCRIPT_PATH)/cgitrc
    CACHE_ROOT = $(CGIT_SCRIPT_PATH)/cgitcache
    prefix = $(CGIT_SCRIPT_PATH)/local

Get the git sources (needed to build libgit):

    git submodule init
    git submodule update

Build and install it:

    gmake install

## Configuration

Make a text file named `cgitrc` where you specified CGIT_CONFIG and add the following (these are some personal defaults to make things cleaner):

    logo=/cgit.png
    root-title=main root title
    root-desc=description for your git server
    root-readme=/home/public/about.md
    virtual-root=/

    about-filter=/home/public/cgit-src/filters/about-formatting.sh
    readme=:README.md
    readme=:README

    include=/home/protected/cgitrepos

Then in the specified file (`cgitrepos`), place your repos, ex:

    repo.url=MyRepo
    repo.path=/home/public/MyRepo.git
    repo.desc=This is my git repository

**And you should be good to go!**
