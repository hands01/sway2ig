#!/usr/bin/env bash

# 1. Fetch notification history from Dunst cleanly
options=$(dunstctl history | jq -r '.data[] | "[\(.appname.content)] \(.summary.content): \(.body.content)"')

if [ -z "$options" ]; then
    # Force the text box to be white when no notifications are found
    rofi -e "No notifications found." -theme-str 'textbox { text-color: #ffffff; }'
    exit 0
fi

# 2. Add the clear action cleanly
menu_content="Clear All History\n$options"

# 3. Call Rofi (it will now natively use your white element-text from config.rasi)
chosen=$(echo -e "$menu_content" | rofi -dmenu -p "Notifications" -i)

# 4. Handle choices
if [ "$chosen" = "Clear All History" ]; then
    dunstctl history-clear
elif [ -n "$chosen" ]; then
    # Force the message dialog box text to be white when you click an alert
    rofi -e "$chosen" -theme-str 'textbox { text-color: #ffffff; }'
fi

