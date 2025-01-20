# Making Tables Responsive With Minimal CSS

2019-06-11

**Update (Oct 2019):** @aardrian wrote a previous post about how changing the `display` properties on tables can impact screen readers. I highly recommend his excellent article [Tables, CSS Display Properties, and ARIA](https://adrianroselli.com/2018/02/tables-css-display-properties-and-aria.html)

---

I find that the need to create responsive table layouts pops up far more often than most developers would expect. The gut reaction might to be implement some sort of custom grid-system or pull in a pre-built library. Don't do this - just use tables and some simple CSS.

My recent article, [Write HTML Like It's 1999](/posts/html-like-1999), received far more attention than I ever expected on HackerNews. With this attention came a few comments mentioning how `table` elements don't play nice with mobile devices or that it's not possible to have a useable layout on smaller screens. *This simply isn't true*.

Included below are two separate demos showing how to optimize `table` HTML for mobile devices using only a minimal amount of CSS. These implementations may not be perfect, but they are far superior to injecting a bunch of custom `div` elements to *look* like tables.

## Demo 1: Just let them scroll

Okay I will admit, this implementation isn't the *greatest* but I find it does work well with huge datasets. Simply set a `min-width` on your parent `table` element and the browser will just require the user to scroll the contents horizontally.


~~~css
table {
    min-width: 800px; /* Set your desired min-width here */
}
~~~


Check out the CodePen below to see it in action:

[Live CodePen Example](https://codepen.io/bradleytaunt/pen/ewObbW/)

I actually prefer this method because of its simplicity and function. Users on mobile are familiar with scrolling since it is one of the most basic actions required. Seeing a "cut-off" table gives them an instant visual cue that they have the ability to scroll the content.

## Demo 2: More <u>flex</u>ible than you think

Using something like `flexbox` tends to work better when you are working with smaller table datasets. All you need to do is add some minor `flexbox` layout at your targeted mobile screen size.

~~~css
/* Using 800px as mobile screen in this example */
@media(max-width: 800px) {
    /* Hide the table headings */
    table thead {
        left: -9999px;
        position: absolute;
        visibility: hidden;
    }
    table tr {
        border-bottom: 0;
        display: flex;
        flex-direction: row;
        flex-wrap: wrap;
        margin-bottom: 40px;
    }
    table td {
        border: 1px solid;
        margin: 0 -1px -1px 0; /* Removes double-borders */
        width: 50%;
    }
}
~~~


[Check out the CodePen demo](https://codepen.io/bradleytaunt/pen/mZbvOb/)

There are some caveats with this approach:

1. We currently hide the `thead` row when in mobile view (only visually - screen readers can still scan it)
2. Some more custom work might be needed depending on how many items per `flexbox` row makes sense (based on project and dataset)

You could keep the table headings and style them the same as the `tbody` contents, but I find hiding them a little cleaner. That choice is entirely up to your personal preference. You can also decide to add heading `span` elements inside the main `tbody` elements like so:

~~~css
/* Default span styling - hidden on desktop */
table td span {
    background: #eee;
    color: dimgrey;
    display: none;
    font-size: 10px;
    font-weight: bold;
    padding: 5px;
    position: absolute;
    text-transform: uppercase;
    top: 0;
    left: 0;
}

/* Simple CSS for flexbox table on mobile */
@media(max-width: 800px) {
    table thead {
        left: -9999px;
        position: absolute;
        visibility: hidden;
    }
    table tr {
        border-bottom: 0;
        display: flex;
        flex-direction: row;
        flex-wrap: wrap;
        margin-bottom: 40px;
    }
    table td {
        border: 1px solid;
        margin: 0 -1px -1px 0;
        padding-top: 35px; /* additional padding to avoid heading overlap */
        position: relative;
        width: 50%;
    }
    /* Show the heading span */
    table td span {
        display: block;
    }
}
~~~


[Live CodePen Example](https://codepen.io/bradleytaunt/pen/mZdzmZ/)

**Updated**: As pointed out by user [mmoez](https://news.ycombinator.com/user?id=mmoez), it is far less repetitive to use `:nth-child` pseudo selectors to implement the heading fields on mobile (as outlined in this [CSS-Tricks article](https://css-tricks.com/responsive-data-tables/)).

## Why should I care to use `table` elements?

Simply put: **accessibility** and **proper semantics**.

Why use a screwdriver when you need a hammer? Sure, you can make that screwdriver look and *almost* work the same as a hammer, but for what purpose? Just use the damn hammer[^1].

Have fun making your tables responsive!

[^1]: I know, this is a terrible analogy...
