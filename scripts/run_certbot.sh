#!/bin/bash

/opt/certbot/venv/bin/certbot renew >> /var/log/letsencrypt.log

for i in /etc/letsencrypt/live/* ; do
  if [ -d "$i" ]; then
    cp $i/fullchain.pem /certs/public/$(basename "$i").pem
    cp $i/privkey.pem /certs/private/$(basename "$i").pem
    cat $i/fullchain.pem $i/privkey.pem > /certs/combined/$(basename "$i").pem
  fi
done
