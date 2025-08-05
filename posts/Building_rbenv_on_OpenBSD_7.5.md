# Building rbenv on OpenBSD 7.5

2024-06-02

I use Ruby (specifically with Jekyll) for a lot of my clubs/projects while using my personal laptop ([X220 ThinkPad](/posts/x220/)) which is runs OpenBSD. Since I recently upgraded to OpenBSD 7.5 I thought it could be helpful for others if I shared my process of building and using `rbenv` to install different Ruby versions.

## Before We Build

First, be sure to install the required packages in order to build from source, and then clone the core `rbenv` repo:

~~~sh
pkg_add git gcc gmake libffi libyaml openssl
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
~~~

## Building `rbenv`

Add `rbenv` to your PATH and initialize it (place this inside your `.bashrc` or `.zshrc` etc):

~~~sh
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local"
eval "$(rbenv init -)"
~~~

Or if you're using `fish` like I am most of the time:

~~~sh
set -x PATH $HOME/.rbenv/bin $PATH
set -x PATH $HOME/.rbenv/shims $PATH
set -x RUBY_CONFIGURE_OPTS "--with-openssl-dir=/usr/local"
status --is-interactive; and source (rbenv init -|psub)
~~~

Then reload your shell: 

~~~sh
# zsh
source ~/.zshrc

# fish
. ~/.config/fish/config.fish
~~~

Next we will need to install `ruby-build` as a `rbenv` plugin. Clone the ruby-build repository into the rbenv plugins directory:

~~~sh
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
~~~

## Installing Ruby and Setting Our Version

Now use `rbenv` to install the desired version of Ruby (we will get an older version for this example):

~~~sh
rbenv install 3.3.0
~~~

If you run into issues, you may need to specify your openssl directory:

~~~sh
RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local" rbenv install 3.3.0
~~~

If you're on a slower machine (like mine) this might take a little bit. Just grab a coffee or a snack while you wait!

Then navigate to your project of choice and set the `local` Ruby version:

~~~sh
rbenv local 3.3.0
~~~

That's it! If you'd prefer to set this version of Ruby for all projects going forward, simply replace `local` with `global`.
