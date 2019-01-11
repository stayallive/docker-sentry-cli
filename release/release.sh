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

export SENTRY_PROJECT=${PLUGIN_SENTRY_PROJECT}

if [[ -z "${PLUGIN_VERSION}" ]]; then
    VERSION=`sentry-cli releases propose-version`
else
    VERSION=${PLUGIN_VERSION}
fi

sentry-cli releases new "$VERSION" --finalize

sentry-cli releases set-commits "$VERSION" --auto

if [[ ! -z "${PLUGIN_SOURCEMAPS}" ]]; then
    if [[ -z "${PLUGIN_SOURCEMAP_PREFIX}" ]]; then
        echo "Missing the sourcemap prefix!"
        exit 1
    fi

    for i in ${PLUGIN_SOURCEMAPS//,/ }
    do
        if [[ ! -z "$SOURCEMAP_NO_REFERENCE" && "$SOURCEMAP_NO_REFERENCE" == "true" ]]; then
            sentry-cli releases files "$VERSION" upload-sourcemaps ${i} --url-prefix "${PLUGIN_SOURCEMAP_PREFIX}" --rewrite --strip-common-prefix --no-sourcemap-reference
        else
            sentry-cli releases files "$VERSION" upload-sourcemaps ${i} --url-prefix "${PLUGIN_SOURCEMAP_PREFIX}" --rewrite --strip-common-prefix
        fi
    done
fi

if [[ ! -z "${PLUGIN_DEPLOY}" ]]; then
    sentry-cli releases deploys "$VERSION" new -e "$PLUGIN_DEPLOY"
fi
