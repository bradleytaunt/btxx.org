# cgit

This page contains a comprehensive guide to setting up cgit on NearlyFreeSpeech. 

**Important**: It is assumed that you already have an account with NFS and also have access to a "site" online.

Most of the following has been lifted from [NearlyFreeSpeech cgit application walkthrough](https://members.nearlyfreespeech.net/wiki/Applications/Cgit) but has been tweaked and updated.

You can see a **live version** [here](https://git.btxx.org).

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
