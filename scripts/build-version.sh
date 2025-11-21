#!/bin/bash

set -e

VERSION_FILE="data/version.json"

mkdir -p data

# If file doesn't exist yet, start at 1
if [ ! -f "$VERSION_FILE" ]; then
  VERSION=1
else
  VERSION=$(jq '.version' "$VERSION_FILE" 2>/dev/null || echo 0)
  VERSION=$((VERSION + 1))
fi

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

cat > "$VERSION_FILE" <<EOF
{
  "version": $VERSION,
  "timestamp": "$TIMESTAMP"
}
EOF

echo "Version updated to v$VERSION"
