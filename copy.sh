#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="/Volumes/GARDEPRO/DCIM"

mkdir -p "$SCRIPT_DIR/copy" "$SCRIPT_DIR/mp4-test" "$SCRIPT_DIR/jpg-test"

if [ ! -d "$SRC" ]; then
  echo "Camera SD card not found at $SRC" >&2
  exit 1
fi

# Copy the files in every folder in DCIM (100MEDIA, 101MEDIA, ...) into copy/.
# The camera reuses file names across folders, so prefix each file with its
# folder name (e.g. 101MEDIA_DSCF0001.JPG) to avoid overwriting.
for dir in "$SRC"/*/; do
  [ -d "$dir" ] || continue
  prefix="$(basename "$dir")"
  for file in "$dir"*; do
    [ -f "$file" ] || continue
    cp "$file" "$SCRIPT_DIR/copy/${prefix}_$(basename "$file")"
  done
done
cp "$SCRIPT_DIR"/copy/*.MP4 "$SCRIPT_DIR/mp4-test"
cp "$SCRIPT_DIR"/copy/*.JPG "$SCRIPT_DIR/jpg-test"
