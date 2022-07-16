#!/bin/bash

function ReadUserKeyboard {
    local message="$1"
    read -p "$message" keyValue
    echo "$keyValue"
}

function WaitForAnyKeyPressed {
    local message="$1"
    echo "$message"
    while true; do
        read -t 3 -n 1
        if [ $? = 0 ] ; then
            break ;
        fi
    done
    PrintMessage -m ""
}

function Eval {
    local expression="$1"
    PrintMessage -m "> $expression" -t "info"
    eval "$expression"
}

function CommandExist {
    local command="$1"
    if [ "$(command -v "$command")" ]; then
        true; return
    fi
    false; return
}
