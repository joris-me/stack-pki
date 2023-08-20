#!/bin/bash

function require () {
    name=$1
    resolved=${!name}
    if [ -z "$resolved" ]; then
        echo "Missing required environment variable: \$$name"
        exit 1
    fi;
}

