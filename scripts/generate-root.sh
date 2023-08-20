#!/bin/bash
source scripts/util.sh

# Inputs
require "PKI_ROOT_NAME"
require "PKI_ROOT_PASSFILE"

# Outputs
require "PKI_ROOT_CERT"
require "PKI_ROOT_KEY"

# step certificate create <subject> <crt-file> <key-file> [...]
step certificate create \
    $PKI_ROOT_NAME \
    $PKI_ROOT_CERT \
    $PKI_ROOT_KEY \
    --password-file $PKI_ROOT_PASSFILE \
    --template template/root.tpl \
    --kty OKP \
    --crv Ed25519

# $PKI_ROOT_NAME is the common name of the certificate
# $PKI_ROOT_CERT is the output cert file
# $PKI_ROOT_KEY is the output key file
# $PKI_ROOT_PASSFILE is the password file to use for securing the key
# `--template template/root.tpl` instructs the use of the specified template
# `--kty OKP` is what key TYPE to generate, "OKP" stands for "octet key pair"
# `--crv Ed25519` is what curve to use
