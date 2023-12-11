#!/bin/bash
progress_bar() {
    local width=50
    local perc=$1
    local fill=$(printf "%${perc}s" | tr ' ' '=')
    local empty=$(printf "%$((width - perc))s")
    printf "[%-100s] %d%%\r" "$fill" "$perc"
}

progress_bar_movement() {
    group_pid=$!
    progress=1
    while kill -0 $group_pid 2>/dev/null; do
        progress_bar $progress
        sleep $1
        if ((progress < 100)); then
            ((progress++))
        fi
    done
    progress_bar 100
}
