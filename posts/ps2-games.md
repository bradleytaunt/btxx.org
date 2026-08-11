# Burning and Playing PS2 Games without a Modded Console

2024-09-02

<div class="alert note">
  <span><b>Important</b> I do not support pirating or obtaining illegal copies of video games. This process should only be used to copy your existing PS2 games for backup, in case of accidental damage to the original disc.</span>
</div>

## Requirements

**Note**: This tutorial is tailored towards macOS and Linux users. Most things should work out-of-the-box on Windows.

You will need:

1. An official PS2 game disc (the one you wish to copy)
2. A PS2 **Slim** console
3. An computer/laptop with a optical DVD drive (or a portable USB DVD drive)
4. Some time and a coffee! (or tea)

## Create an ISO Image of Your PS2 Disc:

### macOS Instructions

1. Insert your PS2 disc into your optical drive.
2. Open **Disk Utility** (Applications > Utilities)
3. In Disk Utility, select your PS2 disc from the sidebar
4. Click on the **File** menu, then select **New Image > Image from [Disc Name]**
5. Choose a destination to save the ISO file and select the format as DVD/CD Master
6. Name your file and click **Save**. Disk Utility will create a `.cdr` file, which is essentially an ISO file

Before we move on, we will need to convert that newly created `cdr` file into `ISO`.

Navigate to the directory where the `.cdr` file is located and use the `hdiutil` command to convert the .`cdr` file to an ISO file:

~~~sh
hdiutil convert yourfile.cdr -format UDTO -o yourfile.iso
~~~

You'll end up with a file named `yourfile.iso.cdr`. Rename it by removing the `.cdr` extension to make it an `.iso` file:

~~~sh
mv yourfile.iso.cdr yourfile.iso
~~~

Done and done.

### Linux (Alpine) Instructions

Insert your PS2 game disc and run:

~~~sh
sudo lsblk
~~~

Look for your optical drive in the list. It's usually labeled something like `/dev/sr0` or `/dev/cdrom`. Once you've identified it, use the `dd` command to create an ISO image from that disc:

~~~sh
sudo dd if=/dev/sr0 of=~/ps2game.iso bs=2048 status=progress
~~~

Give that some time to complete. Once finished, move on.

## Installing Wine

For Mac and Linux users, you will need to install Wine in order to run the ESR patcher:

~~~sh
# macOS
brew install wine-stable

# Linux (Debian)
apt install wine

# Linux (Alpine)
apk add wine
~~~

## Clone & Run the Patcher

The following steps work for both macOS and Linux:

1. Clone the FreeDVDBoot ESR Patcher:<br> `git clone https://git.sr.ht/~bt/fdvdb-esr`
2. Navigate to the cloned project folder:<br> `cd /path/to/fdvdb-esr`
3. The run the executable:<br> `wine FDVDB_ESR_Patcher.exe`

![The patcher running through Wine on macOS](/public/images/patcher-gui.webp)

Now you need to select your previously cloned `ISO` file, use the default Payload setting and then click **Patch!**. After a few seconds your file should be patched.

## Burning Our ISO to DVD

It's time for the main event! 

### macOS Instructions

Insert a blank DVD-R into your disc drive and mount it. Then right click on your patched `ISO` file and run "Burn Disk Image <filename> to Disc...".

From here, you want to make sure you select the slowest write speed and enable verification. Once the file is written to the disc and verified (verification might fail - it is safe to ignore) you can remove the disc from the drive.

### Linux (Alpine) Instructions

For Linux, you will need to install `cdrkit`, which provides the `genisoimage` and `wodim` tools for burning ISOs to DVDs.

~~~sh
sudo apk add cdrkit
~~~

Next, you'll need to identify your DVD writer device. Use the following command:

~~~sh
wodim -scanbus
~~~

This will list the available devices. Typically, the device will be something like `/dev/sr0`.

Now that you have your ISO and the device name, burn the ISO to the DVD:

~~~sh
wodim dev=/dev/sr0 speed=4 -v -data /path/to/your/ps2game.iso
~~~

Take note of the `speed=4` here. This lower speed helps avoid any issues when specifically burning PS2 game files.

(Optional) If you want to verify that the burn was successful, you can use the following command:

~~~sh
md5sum /dev/sr0
~~~

That's it!

## Before Playing the Game

In some instances, you might need to change the PS2 disc speed from **Standard** to **Fast** in the main "Browser" setting before you put the game into your console. After that, enjoy playing your cloned PS2 game!

