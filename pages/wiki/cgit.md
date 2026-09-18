# cgit

This page contains a comprehensive guide to setting up cgit on NearlyFreeSpeech. 

**Important**: It is assumed that you already have an account with NFS and also have access to a "site" online.

Most of the following has been lifted from [NearlyFreeSpeech cgit application walkthrough](https://members.nearlyfreespeech.net/wiki/Applications/Cgit) but has been tweaked and updated.

## Setup `git` Repostories

The first thing we need to do is setting up our `git` repos, with the ability for the public to clone our projects. Each one of your project repos will need to follow this same procedure. 

Make sure to change your "domain" folder accordingly.

~~~sh
cd /home/public/git.btxx.org

mkdir myproject.git
cd myproject.git

git init --bare

# Configure for HTTP access
git config http.getanyfile true
git config http.uploadpack true

# Update server info (crucial for HTTP cloning)
git update-server-info

# Set up the post-update hook
cat > hooks/post-update << 'EOF'
#!/bin/sh
exec git update-server-info
EOF

chmod +x hooks/post-update
~~~

Then make sure to include the following `.htaccess` file at the root of your domain folder (ie. `git.btxx.org/`):

~~~sh
SetEnv GIT_PROJECT_ROOT /home/public/git.btxx.org
SetEnv GIT_HTTP_EXPORT_ALL
~~~

Now you can test this locally by running:

~~~sh
git clone https://git.btxx.org/myproject.git
~~~

## Building cgit

The following assumes that you wish to have cgit running at the top-level of your chosen domain (ie. git.example.com)

SSH into your account then download and unpack the latest release:

~~~sh
git clone git://git.zx2c4.com/cgit cgit-src
cd cgit-src
~~~

Create a cgit.conf file with desired locations:

~~~sh
CGIT_SCRIPT_PATH = /home/public/git.btxx.org
CGIT_DATA_PATH = $(CGIT_SCRIPT_PATH)
CGIT_CONFIG = $(CGIT_SCRIPT_PATH)/cgitrc
CACHE_ROOT = $(CGIT_SCRIPT_PATH)/cgitcache
prefix = $(CGIT_SCRIPT_PATH)/local
~~~

Get the git sources (needed to build libgit):

~~~sh
git submodule init
git submodule update
~~~

Build and install it:

~~~sh
gmake install
~~~

## Configuration

Make a text file named `cgitrc` where you specified CGIT_CONFIG and add the following (these are some personal defaults to make things cleaner):

~~~sh
logo=/cgit.png
root-title=main root title
root-desc=description for your git server
root-readme=/home/public/about.md
virtual-root=/
clone-url=https://git.btxx.org/$CGIT_REPO_URL

about-filter=/home/public/cgit-src/filters/about-formatting.sh
readme=:README.md
readme=:README

include=/home/protected/cgitrepos
~~~

Then in the specified file (`cgitrepos`), place your repos, ex:

~~~sh
repo.url=MyRepo
repo.path=/home/public/MyRepo.git
repo.desc=This is my git repository
repo.owner=Bradley Taunt
~~~

## Configure .htaccess

Inside the root directory containing all of your git repos, add the following `.htacess`:

~~~sh
SetEnv GIT_PROJECT_ROOT /home/public/git.btxx.org
SetEnv GIT_HTTP_EXPORT_ALL

DirectoryIndex cgit.cgi

RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^(.*)$ /cgit.cgi/$1 [L,QSA]
~~~

**And you should be good to go!**

## Optimizing and Blocking Scrapers

The following tweaks to both your `.htaccess`, `robots.txt`, and `cgitrc` files can help mitigate a good amount of malicious bot traffic.

### .htaccess

~~~sh
# ===============================================================
#  NearlyFreeSpeech (Apache 2.4, .htaccess only)
# ===============================================================

SetEnv GIT_PROJECT_ROOT /home/public/git.btxx.org
SetEnv GIT_HTTP_EXPORT_ALL

DirectoryIndex cgit.cgi

RewriteEngine On

# 0. Guards
RewriteCond %{REQUEST_URI} ^/cgit\.cgi(/|$)                              [OR]
RewriteCond %{ENV:REDIRECT_STATUS} !^$
RewriteRule ^ - [L]

RewriteCond %{HTTP_USER_AGENT} (GPTBot|OAI-SearchBot|ChatGPT-User|ClaudeBot|Claude-Web|anthropic-ai|CCBot|Amazonbot|Bytespider|ImagesiftBot|Omgilibot|Diffbot|PerplexityBot|YouBot|meta-externalagent|FacebookBot|Applebot-Extended|DataForSeoBot|AhrefsBot|SemrushBot|MJ12bot|DotBot|PetalBot|SeekportBot) [NC]
RewriteRule ^ - [F,L]

# 1. Whitelist
RewriteCond %{REQUEST_URI} (^|/)(tree|plain|blob|log|commit|diff|rawdiff|patch|blame|snapshot|refs|tag|atom|about|summary|stats)(/|$)   [OR]
RewriteCond %{REQUEST_URI} (^|/)(info|objects|HEAD|git-upload-pack|git-receive-pack)(/|$)
RewriteRule ^ - [E=CGIT:1]

# 2. Everything PHP-related
RewriteCond %{ENV:CGIT} !=1
RewriteCond %{REQUEST_URI} \.php(/|$)                                    [NC]
RewriteRule ^ - [F,L]

# 3. WordPress and CMS probes
RewriteCond %{ENV:CGIT} !=1
RewriteCond %{REQUEST_URI} ^/wp-                                         [NC,OR]
RewriteCond %{REQUEST_URI} ^/(administrator|admin)(/|$)                  [NC,OR]
RewriteCond %{REQUEST_URI} ^/(joomla|drupal|typo3)(/|$)                  [NC,OR]
RewriteCond %{REQUEST_URI} ^/(user/login|login)/?$                       [NC]
RewriteRule ^ - [F,L]

# 4. Config / dotfiles / sensitive  (top level only)
RewriteCond %{ENV:CGIT} !=1
RewriteCond %{REQUEST_URI} ^/\.(env|config|git|svn|hg)(/|$)              [NC,OR]
RewriteCond %{REQUEST_URI} ^/composer\.(json|lock)$                      [NC,OR]
RewriteCond %{REQUEST_URI} ^/config(/|$)                                 [NC,OR]
RewriteCond %{REQUEST_URI} ^/settings\.php$                              [NC,OR]
RewriteCond %{REQUEST_URI} ^/server-(status|info)(/|$)                   [NC]
RewriteRule ^ - [F,L]

# 4.5. Any other top-level dotfile, minus ACME challenges?
RewriteCond %{ENV:CGIT} !=1
RewriteCond %{REQUEST_URI} !^/\.well-known/
RewriteCond %{REQUEST_URI} ^/\.
RewriteRule ^ - [F,L]

# 5. Known exploit scanners
RewriteCond %{ENV:CGIT} !=1
RewriteCond %{REQUEST_URI} ^/(vendor|templates|storage|cgi-bin|owa)(/|$) [NC,OR]
RewriteCond %{REQUEST_URI} ^/(boaform|hudson|phpunit)(/|$)               [NC,OR]
RewriteCond %{REQUEST_URI} ^/(_ignition|_profiler)(/|$)                  [NC,OR]
RewriteCond %{REQUEST_URI} ^/TP(/|$)                                     [OR]
RewriteCond %{REQUEST_URI} ^/(HNAP1|shell)                               [NC,OR]
RewriteCond %{REQUEST_URI} ^/adminer\.php$                               [NC]
RewriteRule ^ - [F,L]

# 6. Backup / dump files  (top level only)
RewriteCond %{ENV:CGIT} !=1
RewriteCond %{REQUEST_URI} ^/[^/]+\.(sql|bak|zip|tar|gz|tgz)$            [NC]
RewriteRule ^ - [F,L]

# 7. cgit catch-all
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^(.*)$ /cgit.cgi/$1 [L,QSA]
~~~

### robots.txt

~~~sh
# robots.txt

# AI assistants
User-agent: ClaudeBot
User-agent: Claude-SearchBot
User-agent: Claude-User
User-agent: claude-code
User-agent: GPTBot
User-agent: OAI-SearchBot
User-agent: ChatGPT-User
User-agent: PerplexityBot
User-agent: Perplexity-User
User-agent: MistralAI-User
User-agent: DuckAssistBot
User-agent: Applebot-Extended
User-agent: Google-Extended
User-agent: meta-externalagent
User-agent: meta-externalfetcher
User-agent: FacebookBot
User-agent: Amazonbot
User-agent: Bytespider
User-agent: TikTokSpider
User-agent: CCBot
User-agent: AI2Bot
User-agent: Ai2Bot-Dolma
User-agent: cohere-ai
User-agent: cohere-training-data-crawler
User-agent: Diffbot
User-agent: Omgilibot
User-agent: omgili
User-agent: ImagesiftBot
User-agent: YouBot
User-agent: Timpibot
User-agent: Webzio-Extended
User-agent: Kangaroo Bot
Disallow: /

# SEO / garbage backlink crawlers
User-agent: AhrefsBot
User-agent: SemrushBot
User-agent: DataForSeoBot
User-agent: MJ12bot
User-agent: DotBot
User-agent: BLEXBot
User-agent: PetalBot
User-agent: SeekportBot
User-agent: serpstatbot
User-agent: Barkrowler
User-agent: ZoominfoBot
Disallow: /

# Everyone else (Googlebot, bingbot, DuckDuckBot, feed readers)
User-agent: *

# Per-commit and per-diff pages
Disallow: /*/commit/
Disallow: /*/commit
Disallow: /*/diff/
Disallow: /*/diff
Disallow: /*/rawdiff/
Disallow: /*/patch/
Disallow: /*/patch
Disallow: /*/blame/

# Tarball generation
Disallow: /*/snapshot/

# Paginated and log views
Disallow: /*/log/
Disallow: /*/log
Disallow: /*/atom/
Disallow: /*/tag/
Disallow: /*/refs/

# Raw file content and per-file trees. (Delete these if you want your source indexed)
Disallow: /*/plain/
Disallow: /*/tree/

Disallow: /*/stats/

# Anything with a query string: ?id=, ?h=, ?ofs=, ?q=, ?showmsg=
Disallow: /*?

# Explicitly permit the useful, cheaper pages
Allow: /$
Allow: /*/about/

Crawl-delay: 30
~~~

### cgitrc

Just this to your existing `cgitrc` you created above, making sure to create the proper `/home/private/cgit-cache` directory.

~~~sh
cache-size=2000
cache-root=/home/private/cgit-cache
cache-root-ttl=60
cache-repo-ttl=60
cache-dynamic-ttl=30
cache-static-ttl=10080
cache-about-ttl=1440
cache-snapshot-ttl=1440
snapshots=
~~~

*Now* everything should be a little more protected. Well, as much as it can on the modern internet...
