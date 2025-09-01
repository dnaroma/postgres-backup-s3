#! /bin/sh

set -eux
set -o pipefail

apk update

# install pg_dump
apk add postgresql-client

# install gpg
apk add gnupg

apk add aws-cli

# install pv for rate limiting
apk add pv

# go-cron support removed - now runs backup directly


# cleanup
rm -rf /var/cache/apk/*
