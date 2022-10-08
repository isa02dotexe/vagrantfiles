#!/bin/bash

chmod -R 777 /etc/motd
cat <<EOF >>/etc/motd
+--------------------+
| bem vindo ao proxy |
+--------------------+
EOF
chmod -R 744 /etc/motd

apt update
apt install nginx -y


cat <<EOF >>/etc/nginx/sites-available/portainer.conf
server {
  listen 81;
#  server_name portainer.seatlcm.com.br;
  location / {
    proxy_pass http://192.168.3.101:9000/;
  }
}
EOF
sudo ln -s /etc/nginx/sites-available/portainer.conf /etc/nginx/sites-enabled/

nginx -t
systemctl restart nginx
cd
