FROM deliverous/certbot

RUN mkdir /certs

RUN apt-get update \
    && apt-get install -q -y cron \
    && rm -rf /var/lib/apt/lists/*

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/crontab
ADD scripts/run_certbot.sh /run_certbot.sh

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/crontab
RUN chmod 0744 /run_certbot.sh

RUN touch /var/log/letsencrypt.log

ENTRYPOINT ["/bin/sh", "-c"]

CMD ["cron -f && tail -f /var/log/letsencrypt.log"]
