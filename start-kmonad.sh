#!/bin/bash
set -e

pkill -x ydotoold || true
ydotoold &
YDOTOOL_PID=$!
sleep 1

echo "Starting KMonad for external keyboard..."
/usr/local/bin/kmonad "$(dirname "$0")/keyboard.kbd" &
KMONAD_INTERNAL_PID=$!

echo "Starting KMonad for internal keyboard..."
/usr/local/bin/kmonad "$(dirname "$0")/bkey.kbd" &
KMONAD_EXTERNAL_PID=$!

echo "Both KMonad instances are running."
wait $KMONAD_INTERNAL_PID $KMONAD_EXTERNAL_PID

kill $YDOTOOL_PID
echo "ydotoold killed."
