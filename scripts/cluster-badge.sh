#!/bin/bash
set -e

SUMMARY="data/gold-summary.json"
BADGE="badges/cluster_badge.svg"

mkdir -p badges

STATUS=$(jq -r '.status' "$SUMMARY")
VERSION=$(jq -r '.version' "$SUMMARY")
SNAPSHOT=$(jq -r '.last_snapshot' "$SUMMARY")

if [ "$STATUS" = "gold" ]; then
  COLOR="#4c1"   # green
else
  COLOR="#dfb317" # yellow (fallback)
fi

cat > "$BADGE" <<EOF
<svg xmlns="http://www.w3.org/2000/svg" width="170" height="28">
  <linearGradient id="smooth" x2="0" y2="100%">
    <stop offset="0" stop-color="#bbb" stop-opacity=".1"/>
    <stop offset="1" stop-opacity=".1"/>
  </linearGradient>

  <rect rx="4" width="170" height="28" fill="#555"/>
  <rect rx="4" x="80" width="90" height="28" fill="$COLOR"/>
  <path fill="$COLOR" d="M80 0h4v28h-4z"/>

  <g fill="#fff" text-anchor="middle"
     font-family="DejaVu Sans,Verdana,Geneva,sans-serif" font-size="12">

    <text x="40" y="18">cluster</text>
    <text x="125" y="18">v$VERSION</text>

  </g>
</svg>
EOF

echo "Cluster badge generated"
