# Installing Older Versions of MongoDB on Arch Linux

2023-09-11

I've recently been using Arch Linux for my main work environment on my ThinkPad X260. It's been great. As someone who is constantly drawn to minimalist operating systems such as Alpine or OpenBSD, it's nice to use something like Arch that boasts that same minimalist approach but with greater documentation/support.

Another major reason for the switch was the need to run older versions of "services" locally. Most people would simply suggest using Docker or vmm, but I personally run projects in self-contained, personalized directories on my system itself. I am aware of the irony in that statement... but that's just my personal preference.

So I thought I would share my process of setting up an older version of MongoDB (3.4 to be precise) on Arch Linux.

## AUR to the Rescue

You will need to target the specific version of MongoDB using the very awesome AUR packages:

~~~sh
yay -S mongodb34-bin
~~~

Follow the instructions and you'll be good to go. Don't forget to create the `/data/db` directory and give it proper permissions:

~~~sh
mkdir -p /data/db/
chmod -R 777 /data/db
~~~

## What About My "Tools"?

If you plan to use MongoDB, then you most likely want to utilize the core database tools (restore, dump, etc). The problem is you can't use the default `mongodb-tools` package when trying to work with older versions of MongoDB itself. The package will complain about conflicts and ask you to override your existing version. This is *not* what we want.

So, you'll have to build from source locally:

~~~sh
git clone https://github.com/mongodb/mongo-tools
cd mongodb-tools
./make build
~~~

Then you'll need to copy the built executables into the proper directory in order to use them from the terminal:

~~~sh
cp bin/* /usr/local/bin/
~~~

And that's it! Now you can run `mongod` directly or use `systemctl` to enable it by default. Hopefully this helps anyone else curious about running older (or even outdated!) versions of MongoDB.
