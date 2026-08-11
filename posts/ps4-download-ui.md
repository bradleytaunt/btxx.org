# PS4 Download UI with Pure CSS

2021-06-20

Overall, I'm fairly impressed with the user interface design of Sony's PS4 system OS. It's minimal and keeps the content front and center. Even with it's sometimes spotty performance hiccups, I've come to enjoy interacting with it.

One of the key UI items I've always been a fan of is the download progress view under the `Notifications` settings. So I figured I'd try my hand at recreating this with pure CSS. Here is the final result:

![PS4 loading screen bar](/public/images/ps4-loading.webp)

[Live CodePen Example](https://codepen.io/bradleytaunt/pen/qBroORG)

Although I've added some of my own improvements (typography spacing, tweaks to the progress bar animation) - the concept it still pretty close to the original.

But enough chit-chat, let's walkthrough how to make it!

## The HTML

As with most of my demos, the HTML is very minimal and straightforward. The PS4 system OS download view needs to show the following:

1. The game's title
2. Full game size, amount downloaded and time remaining
3. Visual progress bar

So we will place the game's title inside our `h2` with a class of `title` (shocking, I know). The details about game size, downloaded amount and time remaining gets placed under a parent `div` with an accompanying `details` class. Finally, we create our progress bar by including a parent `div` with a class of `progress` that contains a child `div` with a class of `inner-progress`.

Pretty clean and easy to understand.


    <div class="wrapper">
        <img src="https://upload.wikimedia.org/wikipedia/commons/0/00/PlayStation_logo.svg" alt="PS4" class="logo">
        <h2 class="title">Detroit: Become Human</h2>
        <div class="details">
            <p>Update File</p>
            <p>13.45/17.50 GB (21 Minutes Left)</p>
        </div>
        <div class="progress">
            <div class="inner-progress"></div>
        </div>
    </div>


## The CSS

Now it's time to utilize all those classes in the HTML above to craft our PS4 UI recreation. I'll break this section down into digestible chunks to avoid overwhelming you by vomiting out a bunch of CSS spaghetti.

First we'll add a bunch of QOL improvements to help better showcase the demo (adding custom fonts, center content etc.).

This part is completely *optional*:


    /* Import fonts */
    @import url('https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@200;400&display=swap');
    
    /* Gradient background styling, height overrides */
    body {
        background: linear-gradient(#226AB6 0%, #144E8A 100%) no-repeat;
        color: white;
        display: block;
        font-family: 'Source Sans Pro', sans-serif;
        font-weight: 200;
        height: 100vh;
    }
    
    /* Wrapper to center content */
    .wrapper {
        margin: 0 auto;
        max-width: 800px;
        padding: 4rem 0 0;
    }
    
    /* Optional PS4 logo */
    .logo {
        display: block;
        filter: invert(1);
        margin: 0 0 2rem 0;
        opacity: 0.5;
        width: 60px;
    }


Now for the styling that *actually matters*. First we will style the game's title and accompanying details (`flexbox` to the rescue again!):


    h2.title {
        font-weight: 400;
        margin: 0;
    }
    
    .details {
        display: flex;
        justify-content: space-between;
        margin: 0.2rem 0 0;
    }
    .details p {
        margin: 0;
    }


Not a whole lot of code to get things looking proper, eh? Next we move on to the progress bar. This is *slightly* more interesting since we are going to utilize the `before` pseudo element - which sounds more complex than it actually is. Pay close attention to the pseudo element and how it calls the `progress-bar-shine` animation - more on that later.


    .progress {
        background: #226AB6;
        border: 1px solid white;
        height: 15px;
        margin: 2rem 0 0;
        position: relative;
        width: 100%;
    }
    .progress:before {
        animation: progress-bar-shine 2.5s infinite;
        background: linear-gradient(to left, white 0%, transparent 100%);
        border-radius: 10px;
        content:'';
        filter: blur(8px);
        height: 100%;
        opacity: 0.8;
        position: absolute;
        transform:translateX(0);
        width: 50px;
    }
    .inner-progress {
        background: white;
        height: 100%;
        opacity: 0.6;
        width: 450px;
    }


Almost finished! We just need to animate that `before` pseudo element with a simple `keyframes` at-rule:


    @keyframes progress-bar-shine {
        to {
        transform:translateX(450px);
        opacity:0;
        }
    }


## Wrapping Up

Although far from perfect, this experiment still explores what can be created (or in this case, *re*created) in the browser using just pure CSS. Remember, you don't have to reach for JavaScript just because you can!
