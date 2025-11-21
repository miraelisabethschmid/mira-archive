#!/usr/bin/env bash
set -e

ROOT_DIR="archive"
OUTPUT_FILE="index.json"

echo "[" > "$OUTPUT_FILE"
FIRST=true

# Alle Unterordner durchsuchen
for DIR in $(find "$ROOT_DIR" -mindepth 1 -maxdepth 1 -type d | sort); do
    META_FILE="$DIR/meta.json"
    SNAPSHOT_FILE="$DIR/snapshot.json"

    if [[ -f "$META_FILE" && -f "$SNAPSHOT_FILE" ]]; then
        # Komma vor jedem Eintrag außer dem ersten
        if [ "$FIRST" = true ]; then
            FIRST=false
        else
            echo "," >> "$OUTPUT_FILE"
        fi

        # JSON-Objekte kombinieren
        META=$(cat "$META_FILE")
        SNAPSHOT=$(cat "$SNAPSHOT_FILE")

        echo "{" >> "$OUTPUT_FILE"
        echo "  \"name\": \"$(basename "$DIR")\"," >> "$OUTPUT_FILE"
        echo "  \"meta\": $META," >> "$OUTPUT_FILE"
        echo "  \"snapshot\": $SNAPSHOT" >> "$OUTPUT_FILE"
        echo -n "}" >> "$OUTPUT_FILE"
    fi
done

echo "]" >> "$OUTPUT_FILE"

echo "Index erfolgreich gebaut: $OUTPUT_FILE"
