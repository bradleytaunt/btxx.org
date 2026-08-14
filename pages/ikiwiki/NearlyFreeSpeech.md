# Setting Up ikiwiki on NearlyFreeSpeech

This page documents step-by-step how to properly setup and customize *ikiwiki* on [NearlyFreeSpeech](https://nearlyfreespeech.net). 

A good deal of the documentation here has been lifted from [ikiwiki.info/tips/nearlyfreespeech/](https://ikiwiki.info/tips/nearlyfreespeech/) but altered and updated.

## Register for an account and set up a site

After you get an account, create a site using their web interface.

Mine is named `ikiwiki-test` and I used their DNS instead of getting my own, resulting in http://ikiwiki-test.nfshost.com/. (Not being kept up anymore.)

They gave me 2 cents free funding for signing up, which is enough to pay for 10 megabytes of bandwidth, or about a thousand typical page views, at their current rates. Plenty to decide if this is right for you. If it is, $5 might be a good starting amount of money to put in your account.

## ssh in and configure the environment

ssh into their server using the ssh hostname and username displayed on the site's information page. Example:

~~~sh
ssh username_ikiwiki-test@ssh.phx.nearlyfreespeech.net
~~~

Now set up `.profile` to run programs from `~/bin`.

~~~sh
cd $HOME
echo "PATH=$PATH:$HOME/bin" > .profile
. .profile
~~~

## Download an unpack ikiwiki

First, be sure to be under the proper `private` directory:

~~~sh
cd /home/private
~~~

Use `wget` to download the ikiwiki tarball. You can find the `tar` file at the bottom of this page: [packages.debian.org/unstable/source/ikiwiki](https://packages.debian.org/unstable/source/ikiwiki)

Then unpack it:

~~~sh
tar zxvf ikiwiki*.tar.gz
~~~

## Build and install ikiwiki

~~~sh
cd ikiwiki
export MAKE=gmake
perl Makefile.PL INSTALL_BASE=$HOME PREFIX=
$MAKE
$MAKE install
~~~

## Create your wiki

All it takes to create a fully functional wiki using ikiwiki is running one command.

~~~sh
ikiwiki --setup /etc/ikiwiki/auto.setup
~~~

Or, set up a blog with ikiwiki, run this command instead.

~~~sh
ikiwiki --setup /etc/ikiwiki/auto-blog.setup
~~~

Either way, it will ask you a couple of questions.

    What will the wiki be named? foo
    What revision control system to use? git
    What wiki user (or openid) will be admin? username
    Choose a password:

Then, wait for it to tell you an url for your new site..

    Successfully set up foo:
    url:         http://example.com/~username/foo
    srcdir:      ~/foo
    destdir:     ~/public_html/foo
    repository:  ~/foo.git
    To modify settings, edit ~/foo.setup and then run:
    ikiwiki --setup ~/foo.setup

We are almost done, but some parameters will most likely be incorrect. Edit your `foo.setup` file and change:

- `url` to `yoursitename.nfshost.com`
- `srcdir` to `/home/private/foo`
- `destdir` to `/home/public`
- `cgiurl` to `http://yoursitename.nfshost.com/ikiwiki.cgi`
- `cgi_wrapper` to `/home/public/ikiwiki.cgi`

Now rebuild again using:

~~~sh
ikiwiki --setup foo.setup
~~~


All done with building ikiwiki!

## Setting up SSL

<div class="alert">
  <span><b>Note</b>NearlyFreeSpeech now offers automatic issuing of SSL certificates. The runner below is no longer needed.</span>
</div>

Navigate to your main `public` directory and run the following:

~~~sh
tls-setup.sh
~~~


Follow the easy instructions and you'll have proper SSL setup in seconds!
