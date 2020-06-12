FROM getsentry/sentry-cli:1

ADD release.sh /bin/
RUN chmod +x /bin/release.sh

ENTRYPOINT /bin/release.sh
