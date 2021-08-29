#!/usr/bin/env bash

# Terminate any already running instances of polybar
kill -SIGTERM "$(pidof polybar)"
# If all bars have IPC enabled, it is also possible to use
# polybar-msg cmd quit

# Launch main bar
echo "---" | tee -a /tmp/polybar.log
polybar main 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched..."
