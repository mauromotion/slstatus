#!/bin/bash

CACHE_FILE="/home/mauromotion/.cache/check_updates.cache"
CACHE_INTERVAL=300 # 5 minutes

# Check if the cache file exists and is not older than the interval
if [ -f "$CACHE_FILE" ]; then
	if [ "$(($(date +%s) - $(date +%s -r "$CACHE_FILE")))" -lt "$CACHE_INTERVAL" ]; then
		cat "$CACHE_FILE"
		exit 0
	fi
fi

if ! updates_arch=$(checkupdates 2>/dev/null | wc -l); then
	updates_arch=0
fi

if ! updates_aur=$(yay -Qum 2>/dev/null | wc -l); then
	updates_aur=0
fi

updates=$((updates_arch + updates_aur))

if [ "$updates" -gt 0 ]; then
	echo " $updates | " >"$CACHE_FILE"
	echo " $updates | "
else
	echo "​" >"$CACHE_FILE"
	echo "​"
fi
