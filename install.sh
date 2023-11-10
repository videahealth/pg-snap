#!/bin/sh

REPO="videahealth/pg-snap"

API_URL="https://api.github.com/repos/$REPO/releases/latest"

LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' "$API_URL")

TAG_NAME=$(echo "$LATEST_RELEASE" | sed -n 's/.*"tag_name": "\([^"]*\)".*/\1/p')

ARCH=$(uname -m)

if [ "$ARCH" = "arm64" ]; then
    BINARY_ARCHIVE="pg-snap-v$TAG_NAME-aarch64-apple-darwin.tar.gz"
elif [ "$ARCH" = "x86_64" ]; then
    BINARY_ARCHIVE="pg-snap-v$TAG_NAME-x86_64-apple-darwin.tar.gz"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

DOWNLOAD_URL="https://github.com/$REPO/releases/download/$TAG_NAME/$BINARY_ARCHIVE"

curl -L -o "/tmp/$BINARY_ARCHIVE" "$DOWNLOAD_URL"
tar -xzf "/tmp/$BINARY_ARCHIVE" -C /tmp

BINARY_PATH="/tmp/pg-snap"

if [ -f "$BINARY_PATH" ]; then
    sudo mv "$BINARY_PATH" /usr/local/bin/pg_snap
    sudo chmod +x /usr/local/bin/pg_snap
    echo "pg_snap installed successfully."
else
    echo "Failed to find the pg_snap binary in the archive."
    exit 1
fi

/usr/local/bin/pg_snap -h