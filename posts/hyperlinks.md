# Hyperlinks Should Have Context

2025-12-18

While poorly implemented links can cause minor annoyances for users, improper **interactive** links can often lead to a *loss* of users.

That's why, if you have interactive links on a website or application, it helps to include detailed context. This avoids incorrect actions being triggered or users second-guessing themselves and needing support. You can achieve this through what I call "invisible hand-holding". It's not as aggressive as having forced tutorials or treating your customers like idiots, but still provides them with a sense of guidance.

Let's explore a fictional example:

Jim's Potato Emporium is a subscription service that delivers bags of potatoes to subscribers on a monthly basis. Customers have the option to subscribe via three tiers:

- Small: $5/month for 1 pound bag
- Medium: $10/month for 2 pound bag
- Large: $15/month for 3 pound bag

Keeping things simplistic for our example, new customers need to be able to subscribe to a tier from a main "pricing" page. The default user experience (UX) would likely involve three *interactive* links (or "actions"). Each link would setup a new subscription based on the corresponding tier. We will ignore any type of account creation or payment setup that would follow, to keep things streamlined.

**Task**: The potential customers need to be aware of each tier's name, monthly price, and amount (of potatoes).

Very often, the go-to approach is an over-bloated table like so:

---

<table border="1">
  <thead>
    <tr>
      <th>Small</th>
      <th>Medium</th>
      <th>Large</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>$5/m</td>
      <td>$10/m</td>
      <td>$15/m</td>
    </tr>
    <tr>
      <td>1 lb</td>
      <td>2 lbs</td>
      <td>3 lbs</td>
    </tr>
    <tr>
      <td><a href="#">Subscribe</a></td>
      <td><a href="#">Subscribe</a></td>
      <td><a href="#">Subscribe</a></td>
    </tr>
  </tbody>
</table>

---

Notice how much bouncing around your eyes need to do for the example above? Not the best experience. Humans are familiar with reading and speaking in clear sentences. Breaking things apart into categorized, one-word items doesn't always help easily convey your context.

Let's try that again but in a more natural, sentence based structure:

---

### Jim's Potato Subscriptions

**Small**:<br> 
[Get 1 lb of potatoes delivered for $5/month](#)

**Medium**:<br>
[Get 2 lb of potatoes delivered for $10/month](#)

**Large**:<br>
[Get 3 lb of potatoes delivered for $15/month](#)

---

Doesn't that flow so much better? Your brain can process these types of sentences faster than trying to scan a table (no matter how minimal). It reads similar to how a person would talk with you face-to-face. These types of hyperlinks are often referred to as *descriptive links*.

> **Get** (action) **1 lb of potatoes** (product) **delivered** (expectation) for **$5/month** (cost)

We can also use this page to set further expectations and answer questions that the user may not have even thought of yet. 

Let's add some more context:

---

### Jim's Potato Subscriptions

Choose a potato subscription by clicking an option below. 

You can always upgrade, downgrade or cancel your subscription at anytime.

**Small**:<br> 
[Get 1 lb of potatoes delivered for $5/month](#)

**Medium**:<br>
[Get 2 lb of potatoes delivered for $10/month](#)

**Large**:<br>
[Get 3 lb of potatoes delivered for $15/month](#)

In the next steps, you will need to create an account and choose a payment method.

---

With this minimal amount of additional text, we have successfully provided:

- a clear description of what they need to do in order to choose a subscription
- reassurance that they can update or cancel at anytime
- a heads up on what to expect *after* clicking an option

You also might be tempted to rewrite the upgrade/downgrade portion as:

> You can always upgrade, downgrade or cancel at anytime

But it isn't absolutely, 100% clear. Cancel what? The subscription? My account? Including the extra instance of the word "subscription" doesn't hurt anyone. What it *actually* does is avoid any possible miscommunication, which is far more important than worrying about tagline "character counts". (Looking at you, marketing teams)

You never want your users making "leaps of faith" when it comes to interactive links or buttons. "What does this link do? Guess I'll click and find out". No user should ever be put into this situation. This is 100% a UX failure.

## Thought Experiment

You should take some time to think through how to apply a similar concept to future interactions this "Jim's Potato Subscription" user might need. Such as:

- skipping their next delivery
- upgrading / downgrading / canceling their subscription
- changing account details

It might sound silly since these types of interactions are found everywhere on the web, but often times they are poorly implemented and we simply "adapt" to the bad UX. The idea of phrasing actionable items into more human-readable *sentences* might not be the best solution every time, but I find it to be a great starting point.

If you can't explain a clickable action with a simple sentence, that action is probably trying to do too much. Simplify.

🥔🥔🥔

## Further Suggested Reading

- [Writing Hyperlinks: Salient, Descriptive, Start with Keyword](https://www.nngroup.com/articles/writing-links/)
- [Write Descriptions for Links](https://accessibility.ecampusontario.ca/accessibility/best-practices/link-descriptions/)