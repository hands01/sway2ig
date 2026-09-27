#!/usr/bin/env bash

# Count the number of notifications currently stored in Dunst history
count=$(dunstctl history | jq '.data[0] | length' 2>/dev/null || echo 0)

if [ "$count" -gt 0 ]; then
    # Displays a lit bell with the notification count
    echo "{\"text\": \" $count\", \"tooltip\": \"$count unread notifications\", \"class\": \"unread\"}"
else
    # Displays a dim/empty bell when history is clear
    echo "{\"text\": \" 0\", \"tooltip\": \"No new notifications\", \"class\": \"none\"}"
fi

