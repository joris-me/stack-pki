#!/bin/bash
source scripts/util.sh

# Inputs
require "PKI_ROOT_CERT" # root certificate (file)
require "PKI_ROOT_KEY" # root key (file)
require "PKI_ROOT_PASSFILE" # root key password (file)

require "PKI_INTER_NAME" # intermediate cert name
require "PKI_INTER_PASSFILE" # intermediate password file

# Outputs
require "PKI_INTER_CERT" # intermediate cert file
require "PKI_INTER_KEY" # intermediate key file

# step certificate create <subject> <crt-file> <key-file> [...]
# `--template template/intermediate.tpl` instructs the use of the specified template
# `--kty OKP` is what key TYPE to generate, "OKP" stands for "octet key pair"
# `--crv Ed25519` is what curve to use
step certificate create \
    --password-file $PKI_INTER_PASSFILE \
    --ca $PKI_ROOT_CERT \
    --ca-key $PKI_ROOT_KEY \
    --ca-password-file $PKI_ROOT_PASSFILE \
    --template template/intermediate.tpl \
    --kty OKP \
    --crv Ed25519 \
    "$PKI_INTER_NAME" \
    $PKI_INTER_CERT \
    $PKI_INTER_KEY
