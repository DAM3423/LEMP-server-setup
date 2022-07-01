#!/bin/bash

/* CORE STUFF */

sudo apt-get update
sudo apt-get -y install git

/* NGINX STUFF */

sudo apt-get -y install nginx

/* MYSQL STUFF */

sudo apt-get -y install mysql-server

# MySQL initial setup
echo "Configuring MySQL..."

sudo mysql_secure_installation <<EOF
n
password
password
Y
Y
Y
Y
EOF

/* PHP STUFF */

sudo apt-get -y install php-fpm php-mysql php-mbstring php-xml php-bcmath php-json php-zip unzip php-curl

if [ ! -f /usr/local/bin/composer ]; then
    echo "Installing Composer..."
    curl -sS https://getcomposer.org/installer | php
    chmod +x composer.phar
    mv composer.phar /usr/local/bin/composer
fi

/* NVM STUFF */

echo "Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
source ~/.bashrc
nvm install 11

/* RESTART SERVICES */
sudo nginx -t
sudo systemctl reload nginx