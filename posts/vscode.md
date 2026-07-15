# Running VSCode in Chromium on OpenBSD

2023-06-05

<div class="alert">
	<span><b>Update (July 07, 2026)</b><br> This unfortunately no longer works.</span>
</div>

VSCode and its many variations are not available on OpenBSD. This doesn't cause issue with many OpenBSD users, but those making the jump from Linux might miss access to such a popular editor. Lucky for us, there is a *hacky* workaround to solve this problem.

## VSCode in the Browser

I tried my best to build something like `code-server` locally and run that directly in my browser - but I failed miserably. Instead, I fell back on [vscode.dev](https://vscode.dev) which is essentially a remote version of `code-server`.

Getting things to work seamlessly proved a little more challenging. I found the best performance was running everything through Chromium with special parameters enabled on launch.

> **Note:** The following assumes you have already installed `chromium`

First we need to disable [unveil](https://man.openbsd.org/unveil.2) for Chromium. This will allow us to access our system files through [vscode.dev](https://vscode.dev) using the "Open folder..." or "Open file..." commands without issue:

~~~sh
chrome --disable-unveil
~~~

Everything should work pretty solid right out the box now - except it doesn't. Syntax highlighting does not work without enabling WASM/WebAssembly. Your experience might be different, but I had to include the following when launching Chromium from the terminal:

~~~sh
ENABLE_WASM=1 chrome --enable-wasm
~~~

Success! We can avoid typing out these complex commands everytime we want to launch our editor by setting up an `alias` (in my case via `.zshrc`):

~~~sh
alias vscode="ENABLE_WASM=1 chrome --enable-wasm --disable-unveil"
~~~

That's it! Now I can just pop open VSCode on OpenBSD by simply running `vscode` in my terminal. Hopefully this can help others slowly transition over to OpenBSD - which you should do because it is amazing!