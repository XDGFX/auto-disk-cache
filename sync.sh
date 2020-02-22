#!/usr/bin/env bash
vers="1.1.0"
now=$(date +"%d-%m-%y")

echo "--- auto disk cache v$vers ---"
echo "Running on $now $(date +"%T")"

# --- START OF VARIABLES ---

source="/mnt/uluru"
destination="/media/wombat/auto-disk-cache"
days=7

# --- END OF VARIABLES ---

sync_dest="${destination}/${now}"  # Initial dest assignment
initial_run=true

# --- START OF FUNCTIONS ---

function remove_old {
    while :; do
        echo "Checking for old directories..."

        if [ "$now" != "$(date +"%d-%m-%y")" ] || $initial_run
        then

            # Update variables
            dest="${destination}/${now}"
            initial_run=false
            now=$(date +"%d-%m-%y")

            # Delete old directories
            while [[ $(find "$destination" -maxdepth 1 -type d | wc -l) -gt $((days + 1)) ]]
            do
                IFS= read -r -d $'\0' line < <(find "$destination" -maxdepth 1 -printf '%T@ %p\0' 2>/dev/null | sort -z -n)
                file="${line#* }"

                echo $file
                rm -rf "$file"
            done
        fi

        # Sleep for 1h
        echo "Cleanup job sleeping..."
        sleep 3600

    done
}

function monitor {
    inotifywait -m -r -e create,modify --format '%w%f' "${source}" | while read newfile
    do
        rsync -RDa0 "${newfile}" ${sync_dest}
    done
}

# --- END OF FUNCTIONS ---

monitor & remove_old