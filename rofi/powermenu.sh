#!/usr/bin/env bash

# 1. Define the 5 options using ONLY symbols
logout="⎋"
suspend="⏸"
hibernate="⏾"
shutdown=""
reboot="↻"

# Combine choices into a single line list
options="$logout\n$suspend\n$hibernate\n$shutdown\n$reboot"

# 2. Open Rofi and capture the user choice
chosen=$(echo -e "$options" | rofi -dmenu -p "Power:" -theme-str '
  window {
      width:            474px;      /* Tightly fitted to contain 5 horizontal boxes */
      location:         north;
      anchor:           north;
      y-offset:         8;
      padding:          5px;
      border-radius:    0px;        
      background-color: #1f1f1f;   
  }
  
  mainbox {
      background-color: transparent;
      children:         [ listview ];
  }

  listview {
      /* Forces everything onto exactly ONE horizontal line */
      layout:           horizontal;
      lines:            5;
      spacing:          12px;      
      cycle:            true;
      dynamic:          true;
      background-color: transparent;
  }

  element {
      /* Perfect square dimensions */
      width:            80px;     
      height:           80px;
      orientation:      vertical;  
      padding:          0px;       
      border-radius:    0px;        
      border:           2px;
      border-color:     #333333A6;   
      background-color: #26262680;   
      text-color:       #ffffff;
  }

  element-text {
      background-color: transparent;
      text-color:       inherit;
      horizontal-align: 0.5;       
      vertical-align:   0.5;       
      font:             "JetBrainsMono Nerd Font 32"; /* Adjusted size to fit the smaller squares */
  }

  element-icon {
      background-color: transparent;
      size:             0px;
  }

  element selected {
      background-color: #1b4d3a;   
      text-color:       #ffffff;
      border-color:     #1b4d3a;     
  }
')

# 3. Execute system command based on selection
case "$chosen" in
    "$logout")
        swaymsg exit
        ;;
    "$suspend")
        # Lock the screen first, then immediately trigger suspend
        swaylock -f && systemctl suspend
        ;;
    "$hibernate")
        # Lock the screen before entering hibernation as well for security
        systemctl hibernate
        ;;
    "$shutdown")
        systemctl poweroff
        ;;
    "$reboot")
        systemctl reboot
        ;;
    *)
        exit 0
        ;;
esac

