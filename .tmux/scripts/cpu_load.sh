#!/bin/bash
#
# Copyright © 2019 Marc Theunissen <mtheunissen82[at]gmail[dot]com>
# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See http://www.wtfpl.net/ for more details.

PREV_TOTAL=0
PREV_IDLE=0

declare -A CORE_MAP=()

# Initialize the CORE_MAP with up to 8 cores
for CORE_NR in $(seq 0 7); do
    CORE_MAP["cpu${CORE_NR}_prev_total"]=0
    CORE_MAP["cpu${CORE_NR}_prev_idle"]=0
done

for ITERATION in $(seq 2); do
    CPU_TOTAL_USAGE=0

    CORES=$(cat /proc/stat | grep "^cpu[0-7]")
    while read -r CORE; do
        # Create array from line
        read -r -a CORE_ARR <<< "$CORE"
        CORE_NAME="${CORE_ARR[0]}"

        MAP_PREV_TOTAL_KEY="${CORE_NAME}_prev_total"
        MAP_PREV_IDLE_KEY="${CORE_NAME}_prev_idle"

        # Core idle time
        CORE_IDLE=${CORE_ARR[4]}

        # Core total time
        CORE_TOTAL=0
        for VALUE in "${CORE_ARR[@]}"; do
            let "CORE_TOTAL=$CORE_TOTAL+$VALUE"
        done

        # Calculate the core usage since previous iteration
        let "CORE_DIFF_IDLE=$CORE_IDLE-${CORE_MAP[${MAP_PREV_IDLE_KEY}]}"
        let "CORE_DIFF_TOTAL=$CORE_TOTAL-${CORE_MAP[${MAP_PREV_TOTAL_KEY}]}"
        let "CORE_DIFF_USAGE=(1000*($CORE_DIFF_TOTAL-$CORE_DIFF_IDLE)/$CORE_DIFF_TOTAL+5)/10"

        CORE_MAP[${MAP_PREV_IDLE_KEY}]="$CORE_IDLE"
        CORE_MAP[${MAP_PREV_TOTAL_KEY}]="$CORE_TOTAL"

        let "CPU_TOTAL_USAGE=$CPU_TOTAL_USAGE+$CORE_DIFF_USAGE"
    done <<< "$CORES"

    if [[ $ITERATION -eq 2 ]]; then
        echo -en "$(printf "%3s%%" $CPU_TOTAL_USAGE)\r"
    fi

    sleep 1
done
