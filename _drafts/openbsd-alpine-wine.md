# Running Wine on Alpine Linux Through QEMU on OpenBSD

2025-03-10

That title is quite a mouthful...

* toc
{:toc}

## Before We Begin

I would like to begin this article (and/or tutorial) with a fitting quote from Jurassic Park:

> Your scientists were so preoccupied with whether or not they could, they didn’t stop to think if they should.
> 
> &middot; *Dr. Ian Malcolm (played by Jeff Goldblum)*

We are not going to debate the merits of running a separate operating system inside OpenBSD through QEMU in order to play games that mostly work running directly on OpenBSD itself. Where would the fun in that be? Instead, we going to dive right in - starting off by downloading the latest Alpine Linux release and configuring QEMU to launch into the installer.

<div class="alert note">
  <span><b>Preface:</b> There are better ways to play old school games on OpenBSD. I did this for fun and because I felt like making things difficult for myself. Please put away your pitchforks...</span>
</div>

For reference, my testing machine has the following specs:

**X220 ThinkPad**

- Intel Core i5 2540M @ 2.6 GHz
- 16GB RAM
- OpenBSD 7.6 running `dwm`

## Requirements

Make sure you have virutalization enabled in the BIOS of your machine and that
your OpenBSD system has up-to-date firmware, ie:

~~~sh
doas fw_update
doas syspatch
~~~

We will be using QEMU for running Alpine inside OpenBSD, so make sure to install that as well:

~~~sh
doas pkg_add qemu
~~~

Then reboot your machine.

## Getting Alpine Linux

First, download the latest release of Alpine Linux to your `Downloads` directory. Make sure to use the "virtual" release version:

~~~sh
cd Downloads
ftp -o alpine-virt.iso https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/x86_64/alpine-virt-x86_64.iso
~~~

For reference, we are using the virtual version of Alpine because it:

- Has a smaller footprint and is optimized for VMs
- Includes virtio drivers for disk, network, and input
- Has no unnecessary desktop components

Next, create a QEMU disk image under a `vms` directory:

~~~sh
cd vms
qemu-img create -f qcow2 alpine.qcow2 10G
~~~

I've set aside 10GB of space for this virtual disk, but feel free to set this
to whatever you prefer.

## Running the Virtual Machine

Time to launch the Alpine image and install it. Run the following (don't worry, I will explain what is happening in a moment):

~~~sh
qemu-system-x86_64 \
    -m 1024M \
    -smp 2 \
    -cdrom alpine-virt.iso \
    -drive file=alpine.qcow2,if=virtio \
    -boot d \
    -netdev user,id=net0 -device virtio-net,netdev=net0 \
    -display gtk
~~~

Let's break everything down:

- `-m 1024M` → 1GB RAM
- `-smp 2` → 2 CPU cores
- `-cdrom alpine-virt.iso` → Boot from the Alpine ISO
- `-drive file=alpine.qcow2,if=virtio` → Use a virtual disk
- `-boot d` → Boot from CD first
- `-netdev user,id=net0 -device virtio-net,netdev=net0` → Enable network
- `-display gtk` → Use GTK GUI

Be sure to change the file directories to match your own username and location of your ISO. If everything went as expected, you should see Alpine Linux running in a GUI window!

**Sidenote:** If you run into *memory allocation* errors, you might need to increase the allowed limit:

~~~sh
ulimit -d unlimited
ulimit -m unlimited
~~~

## Installing Alpine Linux

The Alpine installer is fairly straightforward. Just run `setup-alpine`, follow the guide step-by-step, and be sure to properly set the following parameters during install:

- Choose `virtio` disk (`/dev/vda`)
- Enable `virtio-net` for networking
- Install Alpine to disk

When it reboots, close down QEMU altogether. You'll need to remove the reference to the ISO installer in your initial launch script before running it again.

For the next boot for your Alpine VM, run the following:

~~~sh
qemu-system-x86_64 \
    -m 1024M \
    -smp 2 \
    -drive file=alpine.qcow2,if=virtio \
    -netdev user,id=net0 -device virtio-net,netdev=net0 \
    -display gtk
~~~

If you need hardware acceleration, check if `vmm` is supported on your OpenBSD system. If `vmm` is available, you can use `qemu-system-x86_64 -accel nvmm` for better performance.


## Playing Some Games

### Baldur's Gate 2

### Half-Life 2

### SimCity 3000
