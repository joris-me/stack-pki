#!/bin/bash

function require () {
    var=$1
    if [ -z ${!var} ]; then
        echo "Missing required environment variable: \$$1"
        exit 1
    fi;
}

