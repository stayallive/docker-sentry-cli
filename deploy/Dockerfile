FROM getsentry/sentry-cli:1.37

ADD deploy.sh /bin/
RUN chmod +x /bin/deploy.sh

ENTRYPOINT /bin/deploy.sh
