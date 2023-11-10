#!/bin/sh

REPO="videahealth/pg-snap"

API_URL="https://api.github.com/repos/$REPO/releases/latest"

LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' "$API_URL")

TAG_NAME=$(echo "$LATEST_RELEASE" | sed -n 's/.*"tag_name": "\([^"]*\)".*/\1/p')

ARCH=$(uname -m)

if [ "$ARCH" = "arm64" ]; then
    BINARY_TAR="pg-snap-$TAG_NAME-aarch64-apple-darwin.tar.gz"
elif [ "$ARCH" = "x86_64" ]; then
    BINARY_TAR="pg-snap-$TAG_NAME-x86_64-apple-darwin.tar.gz"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

DOWNLOAD_URL="https://github.com/$REPO/releases/download/$TAG_NAME/$BINARY_TAR"

TMP_DIR=$(mktemp -d)
ARCHIVE_PATH="$TMP_DIR/$BINARY_TAR"
curl -L -o "$ARCHIVE_PATH" "$DOWNLOAD_URL"
if [ ! -f "$ARCHIVE_PATH" ]; then
    echo "Download failed: $DOWNLOAD_URL"
    exit 1
fi

tar -xzf "$ARCHIVE_PATH" -C "$TMP_DIR"
if [ $? -ne 0 ]; then
    echo "Failed to extract the archive: $ARCHIVE_PATH"
    exit 1
fi

BINARY_PATH=$(find "$TMP_DIR" -name "pg-snap" -type f)
if [ -z "$BINARY_PATH" ]; then
    echo "Binary not found in the extracted files."
    exit 1
fi

sudo mv "$BINARY_PATH" /usr/local/bin/pg_snap

sudo chmod +x /usr/local/bin/pg_snap

rm -rf "$TMP_DIR"

pg_snap -h
