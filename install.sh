#!/bin/sh

REPO="videahealth/pg-snap"

API_URL="https://api.github.com/repos/$REPO/releases/latest"

LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' "$API_URL")

TAG_NAME=$(echo "$LATEST_RELEASE" | sed -n 's/.*"tag_name": "\([^"]*\)".*/\1/p')

ARCH=$(uname -m)

if [ "$ARCH" = "arm64" ]; then
    BINARY_NAME="pg-snap-aarch64-apple-darwin"
elif [ "$ARCH" = "x86_64" ]; then
    BINARY_NAME="pg-snap-x86_64-apple-darwin"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

DOWNLOAD_URL="https://github.com/$REPO/releases/download/$TAG_NAME/$BINARY_NAME"

sudo curl -L -o /usr/local/bin/pg_snap "$DOWNLOAD_URL"

sudo chmod +x /usr/local/bin/pg_snap

sh -c 'pg_snap -h'