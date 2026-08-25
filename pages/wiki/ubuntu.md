# Ubuntu

This page contains a wide range of common scripts / application setups for Ubuntu

## MongoDB 3.4 on Ubuntu 23.10

~~~sh
wget http://launchpadlibrarian.net/668089858/libssl1.0.0_1.0.2n-1ubuntu5.13_amd64.deb
sudo apt install ./libssl1.0.0_1.0.2n-1ubuntu5.13_amd64.deb
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

echo "deb http://repo.mongodb.org/apt/ubuntu precise/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
~~~

Now edit `/etc/apt/sources.list.d/mongodb-org-3.4.list`:

~~~sh
deb [trusted=yes] http://repo.mongodb.org/apt/ubuntu precise/mongodb-org/3.4...
~~~

Then finish things up:

~~~sh
sudo apt-get update --allow-unauthenticated
sudo apt-get install -y mongodb-org

sudo mkdir -p /data/db
sudo chmod -R 777 /data/db
~~~

## Redis 6.0.7 on Ubuntu 23.10

~~~sh
sudo apt-get install build-essential tcl
cd /tmp
curl -O http://download.redis.io/releases/redis-6.0.7.tar.gz
tar xzvf redis-6.0.7.tar.gz
cd redis-6.0.7
~~~

Install redis:

~~~sh
make
make test
sudo make install

sudo mkdir /etc/redis
sudo cp /tmp/redis-6.0.7/redis.conf /etc/redis
~~~

Edit `/etc/redis/redis.conf` with the following changes:

- `supervised systemd`
- `dir /var/lib/redis`

Create systemd unit file for redis: `/etc/systemd/system/redis.service`:

~~~sh
[Unit]
Description=Redis In-Memory Data Store
After=network.target

[Service]
User=redis
Group=redis
ExecStart=/usr/local/bin/redis-server /etc/redis/redis.conf
ExecStop=/usr/local/bin/redis-cli shutdown
Restart=always

[Install]
WantedBy=multi-user.target
~~~

Final steps:

~~~sh
sudo adduser --system --group --no-create-home redis
sudo mkdir /var/lib/redis
sudo chown redis:redis /var/lib/redis
sudo chmod 770 /var/lib/redis
~~~

## Ruby 2.7.2 with rbenv on Ubuntu 23.10

Edit the `/etc/apt/sources.list` file:

~~~sh
deb [trusted=yes] http://security.ubuntu.com/ubuntu bionic-security main
~~~

Then run `sudo apt-get update`. After completion, install `libssl1.0-dev`:

~~~sh
sudo apt-get install libssl1.0-dev
~~~

Install `rbenv` and be sure to include the following in `.zshrc`:

~~~sh
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
~~~


