# Qutebrowser

This page contains all the custom configuration for qutebrowser.

### Greasemonkey

All of these scripts should be added under:

~~~sh
~/.local/share/qutebrowser/greasemonkey/
~~~

Then be sure to run the proper command within qutebrowser: `:greasemonkey-reload`

#### Auto Skip YouTube Ads

~~~js
// ==UserScript==
// @name         Auto Skip YouTube Ads 
// @version      1.0.0
// @description  Speed up and skip YouTube ads automatically 
// @author       jso8910
// @match        *://*.youtube.com/*
// @exclude      *://*.youtube.com/subscribe_embed?*
// ==/UserScript==
setInterval(() => {
    const btn = document.querySelector('.videoAdUiSkipButton,.ytp-ad-skip-button')
    if (btn) {
        btn.click()
    }
    const ad = [...document.querySelectorAll('.ad-showing')][0];
    if (ad) {
        document.querySelector('video').playbackRate = 10;
    }
}, 50)
~~~
