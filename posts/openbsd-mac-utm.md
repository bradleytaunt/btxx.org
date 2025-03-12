# Setup an OpenBSD VM on macOS Using UTM

2025-03-12

The [UTM app](https://mac.getutm.app) for macOS is an excellent piece of software for those wanting a streamlined GUI when working with virtual machines. Their existing [Gallery](https://mac.getutm.app/gallery/) of pre-built images is great, but it currently lacks any of the BSDs. Lucky for us, creating your own OpenBSD VM is very straightforward.

<figure>
  <img src="/public/images/openbsd-mac-utm.webp" alt="OpenBSD running inside UTM">
  <figcaption>OpenBSD 7.6 running inside UTM on macOS</figcaption>
</figure>

## Download OpenBSD ISO

Download the latest `arm64` OpenBSD install ISO from the official site:

~~~sh
curl -O https://cdn.openbsd.org/pub/OpenBSD/7.6/arm64/install76.iso
~~~

## Create a UTM Virtual Machine

1. Open UTM
2. Click create a **New Virtual Machine**
3. Select **Virtualize** → **Other**
4. Select **CD/DVD Image** and choose your ISO file
5. Set your **Storage** to your desired size (ie. `15GB`)
6. Set your **Shared Directory** (ie. `Downloads`)
7. Name your VM and click **Continue**

## Tweaking VM Settings

1. Edit the VM config under **QEMU** → **Display** and change it to `virtio-ramfb`.
2. Under **System** check the `Force Multicore` checkbox

## Network & Display

If you require network access, make sure you set `virtio-net-pci` under **Emulated Network Interface** in the **Network** settings tab. This is normally set correctly by default, but you should always double check.

## Installing OpenBSD

1. Start the VM
2. Boot from the OpenBSD install ISO
3. Follow the OpenBSD installation prompts
    * I have a [step-by-step installation guide](/wiki/openbsd/installation/) (if required)
4. After installation choose `Halt`
5. Under **USB Drive** settings remove the ISO from path and set **Image Type** to *Disk Image*
6. Reboot into the OpenBSD VM

Didn't I say it was easy? Now you can start playing with OpenBSD on your Mac! 🐡