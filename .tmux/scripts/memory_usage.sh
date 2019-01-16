#!/bin/bash
#
# Copyright © 2019 Marc Theunissen <mtheunissen82[at]gmail[dot]com>
# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See http://www.wtfpl.net/ for more details.

FREE_DATA=$(free)

MEM_TOTAL_BYTES=$(awk 'NR==2 {print $2}' <<< "$FREE_DATA")
MEM_AVAILABLE_BYTES=$(awk 'NR==2 {print $7}' <<< "$FREE_DATA")
MEM_USAGE_FRACTION=$(bc <<< "scale=3; (($MEM_TOTAL_BYTES-$MEM_AVAILABLE_BYTES)/$MEM_TOTAL_BYTES)")
MEM_USAGE_PERCENTAGE=$(bc <<< "scale=0; $MEM_USAGE_FRACTION*100")

echo -en "$(LC_ALL=C printf "%3.0f%%\r" $MEM_USAGE_PERCENTAGE)\r"
