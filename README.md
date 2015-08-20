messages\_wall
====================

The server side of Chrome Extension messages_wall-chrome\_helper (<https://github.com/zhangyuan/messages_wall-chrome_helper>).

## Deployment

In general, setup the infrastructure (MySQL, Nginx, etc) by user `root`, and deploy the application by user 'deploy' with capistrano.

## Setup the system infrastructure on the server
* Switch to user `root`
* Install Database(MySQL), Web Server(Nginx) and other libraries in the server
```
# If you're using Debian or Ubuntu, followings are the instructions.
# Install libraries (some of them might not be essential)
aptitude install zlib1g-dev libssl-dev libreadline5-dev build-essential libxml2-dev libxslt-dev imagemagick libmagickwand-dev git-core curl tklib libncurses-dev git-core curl build-essential  zlib1g-dev libssl-dev vim tmux screen optipng jpegoptim build-essential zlib1g-dev libpcre3 libpcre3-dev libreadline-gplv2-dev less unzip lsof  libmysqld-dev libmysqlclient-dev

# Install MySQL
aptitude install mysql-server

# Install Nginx
# see http://wiki.nginx.org/Install or use the script https://github.com/zhangyuan/deploy/blob/master/nginx/jessie for jessie
```
* Create the user `deploy` for deployment
* Install NewRelic agent (optional) with lisence key
 
## Setup the application infrastructure on the server
* Switch to user `deploy`
* Install rbenv by user `deploy` ( see https://github.com/fesplugas/rbenv-installer )
* create directory by execute `mkdir ~/apps/wechat/wechat_helper`
 

(Work in Progress)
