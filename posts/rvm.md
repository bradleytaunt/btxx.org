# Installing Ruby with RVM on Alpine Linux

2023-03-16

For some on-going projects I need to switch to different versions of `ruby`. Although there exist many step-by-step instructions on installing and configuring `rvm` for most Linux distros, there aren't many focused on Alpine "daily drivers".

So this post is more or less a helpful document for my future self. If it happens to help others then that's an added bonus!

## Simple Setup

Make sure you have the basic packages first:

~~~sh
apk update
apk add curl gcc gnupg gpg dirmngr procps musl-dev linux-headers zlib zlib-dev openssl openssl-dev yaml-dev
~~~

Next download the latest `stable` version of `rvm` from Github, unpack it, place it in the proper user directory (~/.rvm) and install any required libs:

~~~sh
curl -sSL https://github.com/rvm/rvm/tarball/stable -o rvm-stable.tar.gz
echo 'export rvm_prefix="$HOME"' > ~/.rvmrc
echo 'export rvm_path="$HOME/.rvm"' >> ~/.rvmrc
mkdir rvm && cd rvm
tar --strip-components=1 -xzf ../rvm-stable.tar.gz
./install --auto-dotfiles --autolibs=0
~~~

Now we can remove everything and properly link to `rvm`:

~~~sh
cd ../ && rm -rf rvm-stable stable.tar.gz rvm
source ~/.rvm/scripts/rvm
~~~

Now you can freely install any version of Ruby that you desire!

~~~sh
rvm install ruby-X.X.X
~~~
