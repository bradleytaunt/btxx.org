# WordPress Database Update

The following page contains a collection of scripts to update WordPress for numerous things.

## Updating the URL of the Database

~~~sh
-- Replace in wp_options table
UPDATE wp_options SET option_value = REPLACE(option_value, 'example.com', 'example2.com') WHERE option_name = 'home' OR option_name = 'siteurl';

-- Replace in wp_posts table
UPDATE wp_posts SET post_content = REPLACE(post_content, 'example.com', 'example2.com');
UPDATE wp_posts SET guid = REPLACE(guid, 'example.com', 'example2.com');

-- Replace in wp_postmeta table
UPDATE wp_postmeta SET meta_value = REPLACE(meta_value, 'example.com', 'example2.com');

-- Replace in wp_usermeta table
UPDATE wp_usermeta SET meta_value = REPLACE(meta_value, 'example.com', 'example2.com');

-- Replace in wp_users table
UPDATE wp_users SET user_url = REPLACE(user_url, 'example.com', 'example2.com');
~~~
