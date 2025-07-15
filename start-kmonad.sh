#!/bin/bash

# Kill any existing instances of ydotoold
sudo pkill ydotoold

# Start ydotoold in the background
sudo ydotoold &
YDOTOOL_PID=$!

# Wait a moment for ydotoold to initialize
sleep 1

# Start KMonad
sudo /usr/local/bin/kmonad /home/fryad/Documents/configs/keyboard.kbd

# When KMonad exits, also kill ydotoold
kill $YDOTOOL_PID
