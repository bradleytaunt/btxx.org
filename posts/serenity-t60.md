# Installing SerenityOS on My Old ThinkPad T60

2026-06-28

I recently had the urge to play around with [SerenityOS](https://serenityos.org) on real hardware. Since the project is slightly catered towards older machines, I figured my ThinkPad T60 was a perfect candidate for running on bare metal.

The following is a loose guide for those interested in doing the same. Take note that I built SerenityOS on a separate device running **Fedora**, so the instructions below are based on that.

## Initial Setup

First we need to grab all the packages required to run and build of SerenityOS image:

~~~sh
sudo dnf install texinfo binutils-devel curl cmake mpfr-devel libmpc-devel gmp-devel e2fsprogs ninja-build patch ccache rsync @development-tools @c-development @virtualization
~~~

Now we clone the project:

~~~sh
git clone https://github.com/SerenityOS/serenity.git
cd serenity
~~~

Next we build the cross-toolchain:

~~~sh
Meta/serenity.sh image x86_64
~~~

Then we can create our bootable image (soon to be flashed to our SSD):

~~~sh
cd Build/x86_64 && ninja grub-image
~~~

Now plug in your SSD of choice, find it's destination and flash this created image to it:

~~~sh
sudo dd if=grub_disk_image of=/dev/sdX bs=64M status=progress && sync
~~~

Insert the recently flashed SSD into the laptop and that should be it!

### BIOS Settings

Also be sure to set your default **Serial ATA (SATA)** settings in your BIOS to "Compatibility" and *not* AHCI. That tripped me up at first...

## Our First Boot

Things never run perfectly the first time, do they? I booted up the T60 and was greeted with the following:

~~~sh
StorageManagement: Detected 1 storage devices
  Device: block3:0 (ata, 1 partitions)
    Partition: 1, block100:0 (UUID {00000000-0000-0000-0000-000000000000})
KERNEL PANIC! :^(
StorageManagement: Couldn't find a suitable device to boot
~~~

Uh oh...

I had to do some internet sleuthing to figure out what the heck was happening here. Eventually I came to the conclusion that I need to tweak the details found in the project's `Meta/grub-mbr.cfg` file.

So this:

~~~sh
menuentry 'SerenityOS (normal)' {
 root=hd0,1
 multiboot /boot/Kernel root="lun0:0:0;part0"
}
~~~

need to be changed to:

~~~sh
menuentry 'SerenityOS (normal)' {
 root=hd0,1
 multiboot /boot/Kernel root="block100:0"
}
~~~

Then I needed to rebuild and reflash to the T60:

~~~sh
rm Build/x86_64/grub_disk_image
cd Build/x86_64
ninja grub-image
~~~

## Booting Again...

It's alive! We got a successful boot!

<figure>
  <img src="/public/images/serenity-t60.webp" alt="SerenityOS running on my ThinkPad T60">
  <figcaption>SerenityOS running on my T60. Isn't it beautiful?</figcaption>
</figure>

Things are pretty straight forward once you understand the whole process. Hopefully this inspires you to give SerenityOS a test run as well!
