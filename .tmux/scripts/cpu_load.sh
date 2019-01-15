#!/bin/bash
# Author: Marc Theunissen <mtheuniss82@gmail.com>
# Inspired by script from Paul Colby: https://github.com/pcolby/scripts/blob/master/cpu.sh
# Calculate total CPU percentage per core.

PREV_TOTAL=0
PREV_IDLE=0

declare -A CORE_MAP=()

# Initialize the CORE_MAP with up to 8 cores
for CORE_NR in $(seq 0 7); do
    CORE_MAP["cpu${CORE_NR}_prev_total"]=0
    CORE_MAP["cpu${CORE_NR}_prev_idle"]=0
done

while true; do
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

    echo -en "\r$CPU_TOTAL_USAGE%  \b\b"

    sleep 1
done
