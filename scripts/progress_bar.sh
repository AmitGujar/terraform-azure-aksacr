#!/bin/bash
progress_bar() {
    local width=50
    local perc=$1
    local fill=$(printf "%${perc}s" | tr ' ' '=')
    local empty=$(printf "%$((width - perc))s")
    printf "[%-100s] %d%%\r" "$fill" "$perc"
}

progress_bar_movement() {
    while true; do
        if ! ps -p $! &>/dev/null; then
            break
        fi
        for i in {1..100}; do
            progress_bar $((i * 1))
            sleep $1
        done
    done
    progress_bar 100
}