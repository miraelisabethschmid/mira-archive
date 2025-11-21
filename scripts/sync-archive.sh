#!/bin/bash

set -e

echo "Syncing archive from Badge Canary..."

SOURCE_REPO="https://github.com/miraelisabethschmid/badge-canary.git"
TARGET_FOLDER="archive"

rm -rf "$TARGET_FOLDER"
git clone --depth=1 "$SOURCE_REPO" temp-sync

mkdir -p "$TARGET_FOLDER"
cp -r temp-sync/data/* "$TARGET_FOLDER"/

rm -rf temp-sync

echo "Archive sync complete."
