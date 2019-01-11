# Dockerized Sentry CLI

This image was built to use in a [Drone CI](https://drone.io/) pipeline.

## Release

_See also the [sentry-cli documentation](https://docs.sentry.io/cli/releases/#creating-releases)._

```yaml
steps:
  - name: sentry-release
    image: stayallive/sentry:release
    pull: always
    settings:
      # (required) The Sentry authentication token (https://docs.sentry.io/cli/configuration/)
      sentry_token:
        from_secret: sentry_auth_token
   
      # (required) The Sentry organization this release should be created in
      sentry_org: yourcompany
      
      # (required) The Sentry project this release should be created for
      sentry_project: yourproject
      
      # (optionally) The version of your application that is being released
      # default: auto
      version: ${DRONE_TAG}
      
      # (optionally) Set a custom commit or commit range that is being deployed
      # see: https://docs.sentry.io/cli/releases/#sentry-cli-commit-integration
      # default: auto
      commit: my-repo@${DRONE_COMMIT_BEFORE}...${DRONE_COMMIT_SHA}
      
      # (optionally) Set paths to look for sourcemaps to upload
      # default: empty
      sourcemaps: [ public/build ]
      
      # (optionally, required with sourcemaps) Set the sourcemaps url prefix
      # default: empty
      sourcemap_prefix: ~/build
      
      # (optionally) Sets the `--no-sourcemap-reference` flag when uploading sourcemaps
      # default: false
      sourcemap_no_reference: true
      
      # (optionally) The environment this release is being deployed
      # default: empty
      deploy: production
      
      # (optionally) The Sentry URL for your on-premise installation
      # default: https://sentry.io/
      sentry_url: https://sentry.yourcompany.com/
```

## Deploy

_See also the [sentry-cli documentation](https://docs.sentry.io/cli/releases/#creating-deploys)._

```yaml
steps:
  - name: sentry-deploy
    image: stayallive/sentry:deploy
    pull: always
    settings:
      # (required) The Sentry authentication token (https://docs.sentry.io/cli/configuration/)
      sentry_token:
        from_secret: sentry_auth_token
   
      # (required) The Sentry organization this release should be created in
      sentry_org: yourcompany
      
      # (required) The Sentry project this release should be created for
      sentry_project: yourproject
      
      # (required) The environment this release is being deployed
      # default: empty
      environment: production
      
      # (optionally) The version of your application that is being released
      # default: auto
      version: ${DRONE_TAG}
      
      # (optionally) The Sentry URL for your on-premise installation
      # default: https://sentry.io/
      sentry_url: https://sentry.yourcompany.com/
```
