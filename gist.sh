#!/bin/bash
GITHUB_DOMAIN=github.com
GITHUB_DOMAIN=${1:-$GITHUB_DOMAIN}
GITHUB_USER=autodidacticon
GITHUB_USER=${2:-$GITHUB_USER}
jq -R '{"title": "${whoami", "public": true, "files": {"'$FNAME'": {"content": .}}}' $FNAME | curl -u autodidacticon -X POST -d @- "https://api.github.com/gists"
