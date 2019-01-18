#!/bin/bash
#
# Author: Marc Theunissen <mtheunissen82[at]gmail[dot]com>
#
# Copyright © 2019 Marc Theunissen <mtheunissen82[at]gmail[dot]com>
# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See http://www.wtfpl.net/ for more details.

PREV_SECTORS_READ=0
PREV_SECTORS_WRITTEN=0

for ITERATION in $(seq 2); do
    SDA_DATA=$(cat /sys/block/sda/stat)

    CURRENT_SECTORS_READ=$(awk '{printf $3}' <<< "$SDA_DATA")
    CURRENT_SECTORS_WRITTEN=$(awk '{print $7}' <<< "$SDA_DATA")

    if [[ $ITERATION -eq 2 ]]; then

        MB_READ=$(bc <<< "scale=0; (($CURRENT_SECTORS_READ-$PREV_SECTORS_READ)/2)/1024")
        MB_WRITTEN=$(bc <<< "scale=0; (($CURRENT_SECTORS_WRITTEN-$PREV_SECTORS_WRITTEN)/2)/1024")

        echo -en "$(printf "%3d %3d MB/s" "$MB_READ" "$MB_WRITTEN")\r"
        exit
    fi

    PREV_SECTORS_READ=$CURRENT_SECTORS_READ
    PREV_SECTORS_WRITTEN=$CURRENT_SECTORS_WRITTEN

    sleep 1
done
