#!/usr/bin/env bash
VERS="1.0.0"
NOW=$(date +"%d-%m-%y")

echo "--- auto disk cache v$VERS ---"
echo "Running on $NOW $(date +"%T")"

# -- START OF VARIABLES --

SOURCE=/mnt/uluru
DESTINATION=/media/wombat/auto-disk-cache
DAYS=7

# -- END OF VARIABLES --

echo "Checking for old directories..."

while [[ $(find "$DESTINATION" -maxdepth 1 -type d | wc -l) -gt $((DAYS + 1)) ]]
do
    echo $file
    IFS= read -r -d $'\0' line < <(find "$DESTINATION" -maxdepth 1 -printf '%T@ %p\0' 2>/dev/null | sort -z -n)
    file="${line#* }"

    rm -rf "$file"
done

DEST="$DESTINATION/$NOW"


echo "Cloning files and folders newer than $DAYS days."
echo
echo "Copying new files..."

rsync -RDa0Pv --files-from=<(find $SOURCE -mtime -$DAYS -print0) / $DEST

echo
