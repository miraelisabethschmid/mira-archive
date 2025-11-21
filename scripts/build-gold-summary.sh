#!/bin/bash
set -e

mkdir -p data

VERSION_FILE="data/version.json"
SUMMARY_FILE="data/gold-summary.json"

VERSION=$(jq '.version' $VERSION_FILE)
TIMESTAMP=$(jq -r '.timestamp' $VERSION_FILE)

LAST_SNAPSHOT=$(ls -1 snapshots/*.tgz 2>/dev/null | tail -n 1 | sed 's#snapshots/##' || echo "none")

NOW=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

cat > "$SUMMARY_FILE" <<EOF
{
  "cluster": "mira",
  "generated": "$NOW",
  "version": $VERSION,
  "version_timestamp": "$TIMESTAMP",
  "last_snapshot": "$LAST_SNAPSHOT",
  "status": "gold"
}
EOF

echo "Gold summary created"
