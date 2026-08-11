# Converting HEIF Images with macOS Automator

2023-07-21

Often times when you save or export photos from iOS to iCloud they often render themselves into `heif` or `heic` formats. Both macOS and iOS have no problem working with these formats, but a lot of software programs will not even recognize these filetypes. The obvious step would just be to convert them via an application or online service, right?

Not so fast! Wouldn't it be much cleaner if we could simply right-click our `heif` or `heic` files and convert them directly in Finder? Well, I've got some good news for you...

## Basic Requirements

1. You will need to have [Homebrew](https://homebrew.sh) installed
2. You will need to install the `libheif` package through Homebrew: `brew install libheif`

## Creating our custom Automator script

For this example script we are going to convert the image to JPG format. You can freely change this to whatever format you wish (PNG, TIFF, etc.). We're just keeping things basic for this tutorial. Don't worry if you've never worked with Automator before because setting things up is incredibly simple.

1. Open the macOS Automator from the Applications folder
2. Select `Quick Option` from the first prompt
3. Set "Workflow receives current" to `image files`
4. Set the label "in" to `Finder`
5. From the left pane, select "Library > Utilities"
6. From the presented choices in the next pane, drag and drop `Run Shell Script` into the far right pane
7. Set the area "Pass input" to `as arguments`
8. Enter the following code below as your script and type `⌘-S` to save (name it something like "Convert HEIC/HEIF to JPG")

~~~sh
for f in "$@"
do
/opt/homebrew/bin/heif-convert "$f" "${f%.*}.webp"
done
~~~

## Making Edits

If you ever have the need to edit this script (for example, changing the default format to `png`), you will need to navigate to your `~/Library/Services` folder and open your custom heif Quick Action in the Automator application. 

Simple as that. Happy converting!

If you're interested, I also have some other Automator scripts available:

- [Batch Converting Images to webp with macOS Automator](/posts/batch-webp-conversion/)
- [Convert Files to HTML with macOS Automator Quick Actions](/posts/macos-convert-to-html/)
