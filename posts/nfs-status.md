# Creating a Basic Status Page on NearlyFreeSpeech

2025-05-12

Since I talked about [hosting multiple websites through NearlyFreeSpeech](https://btxx.org/posts/nfs-multiple-websites/) in the past, I thought it would be nice to walkthrough setting up a barebones "status" page that runs automatically on your existing NFS server. This post isn't going to be mind blowing, but it will give you a solid overview of some weekly stats, such as:

- basic system info (FreeBSD stats, etc)
- weekly visitor stats
- weekly traffic by browser type

You can obviously build off of this "skeleton", but I find this works well
enough for my own needs.

## Live Example

You can see a live example of my own status page
[here](https://btxx.org/status.html).

The stats on this page are skewed though, since they take into account all
websites I host through NFS. If you happen to host only a single site on your
account, the data will be much more specific.

## The Status Script

The script that generates this status page is very basic shell. You could use
any language really, but I like to keep things as simple as possible (most
times). Here is the code in all of its glory:

~~~sh
OUTPUT="/home/public/<your_domain_or_site_folder>/status.html"
ACCESS_LOG="/home/logs/access_log"
VISITOR_COUNT=$(awk '{print $1}' "$ACCESS_LOG" | sort | uniq | wc -l)

# Capture system data
OS=$(uname -s)
RELEASE=$(uname -r)
ARCH=$(uname -m)
SHELL=$SHELL
RAM=$(top -b | awk '/Mem:/ {print $2 " used, " $4 " free"}' || echo 'N/A')
UPTIME=$(uptime | sed 's/.*up \([^,]*\),.*/\1/')
LOADAVG=$(uptime | sed 's/.*load averages: //')

{
cat <<EOF
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="color-scheme" content="light dark">
  <title>Status - NearlyFreeSpeech</title>
</head>
<body>

<h1>NearlyFreeSpeech.NET Server Info</h1>
<p>Generated on: $(date)<br>
Stats updated hourly.</p>

<pre>
/\\,-'''''-,/\\
\\_)       (_/
|           |
|           |
 ;         ;
  '-_____-'
</pre>

<h2>System Info</h2>
<table border="1">
  <tr><th>OS</th><td>$OS</td></tr>
  <tr><th>Release</th><td>$RELEASE</td></tr>
  <tr><th>Architecture</th><td>$ARCH</td></tr>
  <tr><th>Shell</th><td>$SHELL</td></tr>
  <tr><th>RAM</th><td>$RAM</td></tr>
  <tr><th>Uptime</th><td>$UPTIME</td></tr>
  <tr><th>Load Average</th><td>$LOADAVG</td></tr>
</table>

<h2>Visitor Stats (Reset Weekly)</h2>
<table border="1">
  <tr><th>Metric</th><th>Value</th></tr>
  <tr><td>Unique Visitors</td><td>$VISITOR_COUNT</td></tr>
</table>

<h2>Browser Traffic (Reset Weekly)</h2>
<table border="1">
  <tr><th>Browser</th><th>Count</th></tr>
EOF

# Output each browser row
awk -F\" '{print $6}' "$ACCESS_LOG" | grep -v '^-$' | \
awk '
  /Edg/                       { browsers["Edge"]++ }
  /Chrome/ && !/Edg/          { browsers["Chrome"]++ }
  /Safari/ && !/Chrome/       { browsers["Safari"]++ }
  /Firefox/                   { browsers["Firefox"]++ }
  /MSIE/ || /Trident/         { browsers["Internet Explorer"]++ }
  /curl/                      { browsers["curl"]++ }
  /wget/                      { browsers["wget"]++ }
  END {
    for (b in browsers) {
      printf "<tr><td>%s</td><td>%d</td></tr>\n", b, browsers[b]
    }
  }
'

cat <<EOF
</table>
</body>
</html>
EOF

} > "$OUTPUT"
~~~

Be sure to change the main variables with your own info (file path, etc.) and
you should be good to go. Now save this script and place it on your main NFS
server under the `/home/public` directory. 

<div class="alert warning">
<span><b>Important!</b>
Before you setup your automated script, make sure you have enabled <code>Access
Logs</code> under your NFS site panel (found under <strong>Log Settings</strong>)</span>
</div>


Our next step is to setup our cronjob.

## Automating Our Script

Setting up a `cronjob` through NearlyFreeSpeech is handled through the main
admin site settings. Login and navigate to your **Sites** panel and select your
desired website. Under the sidebar heading **Actions** select **Manage
Scheduled Tasks**. Next, click **Add Scheduled Task**.

On the following page you will want to enter the following:

- **Tag**: Whatever name you want
- **URL or Shell Command**: `/bin/sh /home/public/<name_of_your_script>.sh`
- **Enabled**: Yes
- **User**: me
- **Hour**: `*` (run every hour)
- **Day of Week**: Every
- **Date**: `*` (every day of the month)

Now click Save and you're done! Since your script won't run right away, feel
free to run it directly from the command line for the first time.

Happy status page building!
