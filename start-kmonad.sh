#!/bin/bash
set -e

# Kill any existing ydotoold (if running)
pkill -x ydotoold || true

# Start ydotoold in the background
ydotoold &
YDOTOOL_PID=$!

# Wait for ydotoold to initialize
sleep 1

# Start KMonad with config
/usr/local/bin/kmonad "$(dirname "$0")/keyboard.kbd"

# When KMonad exits, also kill ydotoold
kill $YDOTOOL_PID
