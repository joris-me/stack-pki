#!/bin/bash

function require () {
    echo "Require: $1"
    var=$1
    echo "Var: $var"
    echo "Var resolved: ${!var}"
    if [ -z ${!var} ]; then
        echo "Missing required environment variable: \$$1"
        exit 1
    fi;
}

