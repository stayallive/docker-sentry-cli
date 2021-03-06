#!/bin/sh

set -e

if [[ ! -z "${PLUGIN_SENTRY_URL}" ]]; then
    export SENTRY_URL=${PLUGIN_SENTRY_URL}
fi

if [[ -z "${PLUGIN_SENTRY_TOKEN}" ]]; then
    echo "Missing your authentication token!"
    exit 1
fi

export SENTRY_AUTH_TOKEN=${PLUGIN_SENTRY_TOKEN}

if [[ -z "${PLUGIN_SENTRY_ORG}" ]]; then
    echo "Missing your organization!"
    exit 1
fi

export SENTRY_ORG=${PLUGIN_SENTRY_ORG}

if [[ -z "${PLUGIN_SENTRY_PROJECT}" ]]; then
    echo "Missing your project!"
    exit 1
fi

if [[ -z "${PLUGIN_ENVIRONMENT}" ]]; then
    echo "Missing your environment!"
    exit 1
fi

export SENTRY_PROJECT=${PLUGIN_SENTRY_PROJECT}

if [[ -z "${PLUGIN_VERSION}" ]]; then
    VERSION=`sentry-cli releases propose-version`
else
    VERSION=${PLUGIN_VERSION}
fi

sentry-cli releases deploys "$VERSION" new -e "$PLUGIN_ENVIRONMENT"
