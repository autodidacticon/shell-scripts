#!/bin/bash
GITHUB_DOMAIN=github.com
GITHUB_DOMAIN=${1:-$GITHUB_DOMAIN}
API_ROOT=api.github.com
if [ "$GITHUB_DOMAIN" != "github.com" ]; then
    API_ROOT=$GITHUB_DOMAIN/api/v3
fi
GITHUB_USER=autodidacticon
GITHUB_USER=${2:-$GITHUB_USER}

SSH_KEY_DIR=~/.ssh/id_rsa.pub
SSH_KEY_DIR=${3:-$SSH_KEY_DIR}

jq -R -s '{"title": "'`whoami`\@`hostname`'", "key":  .}' ~/.ssh/id_rsa.pub | curl -u $GITHUB_USER -X POST -d @- "https://$API_ROOT/user/keys"
