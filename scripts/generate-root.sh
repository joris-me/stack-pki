#!/bin/bash
source scripts/util.sh

# Inputs
require "PKI_ROOT_NAME" # root certificate name
require "PKI_ROOT_PASSFILE" # root key password file 

# Outputs
require "PKI_ROOT_CERT" # root certicate file
require "PKI_ROOT_KEY" # root key file


# step certificate create <subject> <crt-file> <key-file> [...]
# `--template template/root.tpl` instructs the use of the specified template
# `--kty OKP` is what key TYPE to generate, "OKP" stands for "octet key pair"
# `--crv Ed25519` is what curve to use
step certificate create \
    --password-file $PKI_ROOT_PASSFILE \
    --template template/root.tpl \
    --kty OKP \
    --crv Ed25519 \
    "$PKI_ROOT_NAME" \
    $PKI_ROOT_CERT \
    $PKI_ROOT_KEY
