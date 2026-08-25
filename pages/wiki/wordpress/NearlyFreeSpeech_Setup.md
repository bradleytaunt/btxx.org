# Installing WordPress on NearlyFreeSpeech

## Download WordPress

We will use the `wp-cli` that comes packaged with NearlyFreeSpeech (NFS):

1. Connect to your site via SSH.
2. Change to the directory you want to be the base of your blog (e.g. /home/public if WordPress will be running the whole site, or /home/public/blog if you want to share the site with other content).

For help using WP-CLI from the SSH command line, use this command:

~~~sh
wp help
~~~

To download and unpack the latest version of WordPress, enter the following command:

~~~sh
wp core download
~~~

## Create a MySQL Process and Database

Follow the instructions in the NearlyFreeSpeech.NET FAQ to [create a MySQL process](https://members.nearlyfreespeech.net/faq?q=MySQL#MySQL) if you haven't already.

Next, [create a new database](https://members.nearlyfreespeech.net/faq?q=CreateDatabase#CreateDatabase) within that process. Note the name of the process and the name of the database.

**Important**: Do not use your own MySQL credentials to connect WordPress to your database. Instead, create a new user. This will protect your member password in the event that your site becomes compromised.


- Click on the [MySQL tab](https://members.nearlyfreespeech.net/mysql) in the member interface
- Click "[Open phpMyAdmin](https://phpmyadmin.nearlyfreespeech.net/" in the Actions box.
- Enter the DSN ("Server") of your MySQL Process, MySQL username, and MySQL password. The DSN and username can be found on the Process Information page in our member UI.
- Click on the "Users" tab.
- Click "Add user." (It's toward the bottom left of the page.)
- Give the user a descriptive name. We'll use exampledbuser here, but you should pick something better, like wpuser or something representative of your blog.
- Make sure to leave the Host: selectbox on "Any host."
- Click the "Generate" link to generate a nice strong password.
- Use cut and paste to copy the new password somewhere, you'll need it later. (We'll use dbpassword here.)
- Grant the following permissions to the new user:
    - All the permissions except "file" in the "data" box,
    - Everything in the "structure" box, and
    - "LOCK TABLES" in the "administration" box.
- Click the "Go" button in the lower right.
- Exit phpMyAdmin.

## Generate a WordPress Configuration File

At the SSH command line (replace the examples with the info for the database and user you created above):

    wp core config --dbhost=example.db --dbname=exampledb --dbuser=exampledbuser --dbpass=dbpassword
    chmod 644 wp-config.php

## Run the WordPress Installation and Setting Permissions

To get your permalinks to work properly, you must set up an .htaccess file. 


1. Go to the Dashboard for your WordPress site. (e.g. https://www.example.com/wp-admin/index.php)
2. In the navigation sidebar, find Settings and, under that, Permalinks.
3. Select your preferred link style under "Common Settings." (We like "Day and name.")
4. Scroll down and select the "Save Changes" button.

Next, create an `.htaccess` file for your WordPress site. We suggest doing this directly from the SSH command line using the cat shell command:

~~~sh
cat >.htaccess <<NFSNRULES # This line is a shell command, not part of .htaccess!
RewriteEngine On
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]
NFSNRULES
~~~

If you prefer, you can copy-paste the text into an editor:

~~~sh
RewriteEngine On
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]
~~~

We need to run the following commands in order to install, uninstall, activate, and deactivate plugins/themes from within the admin web GUI of WordPress:

~~~sh
chgrp web .htaccess
chmod 664 .htaccess
chgrp -R web *
find . -type d -exec chmod 775 {} \;
find . -type f -exec chmod 664 {} \;
wp config set FS_METHOD direct
~~~

## Enable File Uploading

In your main WordPress installation folder enter the following SSH commands:

~~~sh
cd wp-content
mkdir -p uploads
chgrp -R web uploads
chmod -R 775 uploads
~~~

## Keeping WordPress Up-To-Date Automatically via Command Line

It is **critically** important to keep your WordPress installation up-to-date including, if applicable, your theme and plugins. PHP, WordPress, and WordPress themes and plugins all have a track record of security problems. Most of those get fixed quickly, but if you don't update, you don't get the fixes.

To help you keep WordPress up-to-date, NFS provides a streamlined script.

This command, which must be run from an interactive ssh session, will set up our system to check your WordPress install (and themes & plugins) for you every day, and update them automatically when needed:

~~~sh
wp-update.sh -a
~~~

By default, it will tell you via email when updates happen. If you don't want that, just add `-q` (for "quiet") to the command. It will work silently unless there is an error.

If you get errors from wp-cron (not wp-update) about failed automatic updates, you may also wish to add this to your wp-config.php file:

~~~sh
define( 'AUTOMATIC_UPDATER_DISABLED', true );
~~~

This disables the insecure automatic updater bundled with recent versions of WordPress.

**Do not attempt** to use WordPress's built-in ability to update itself through its admin panel. That insecure, outdated approach should not still exist. It does not work on NFS, which is a feature, not a bug. Getting it to work requires almost completely destroying your site's security, thereby ensuring that any undiscovered security flaw can enable hackers to completely obliterate your site. The update methods described here are faster, easier, and safer.

## Logging In

You should be able to navigate to `yourwebsite.com/wp-admin`, login and have everything work as expected. Congrats - enjoy your blog!

Below you can find more advanced configuration to get the most out of your WordPress project.

---

## Backing up WordPress

NFS recommends backing up your WordPress setup on a regular basis.

This is a two-step process. You must back up both the files and the database.

### Backing up WordPress Files

To back up your WordPress files directly from a Unix-like system of your own, you can use a command like:

~~~sh
ssh yourmembername_siteshortname@ssh.phx.nearlyfreespeech.net tar -C /home/public -cvf - . | gzip >name-of-wordpress-backup.tar.gz
~~~

To back up WordPress to a file on our system that you can transfer via SFTP to your own computer, you can use a command like:

~~~sh
tar -C /home/public -cvzf /home/tmp/name-of-wordpress-backup.tar.gz .
~~~

This assumes that your WordPress install is in the default location (`/home/public`). It will put your backup file in your `/home/tmp` directory.

Do not try to back up your WordPress folder into your WordPress folder, as that occasionally results in attempts to use infinite disk space by trying to back up the backup of the backup of the backup of the...

### Backing up the WordPress Database

If you have a Unix-like system of your own (e.g. macOS or Linux), you can do the backup directly from there using your local command prompt using the MySQL username and password you created for WordPress:

~~~sh
ssh yourmembername_siteshortname@ssh.phx.nearlyfreespeech.net wp db export - | gzip >wordpress-backup.sql.gz
~~~

Or you can do it from the SSH command line via WP-CLI:

~~~sh
wp db export /home/tmp/wordpress-backup.sql
~~~

The `wordpress-backup.sql` file this generates will be stored in your site's `/home/tmp` directory. Download it from there to have a local copy.
