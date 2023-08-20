#!/bin/bash
source ./util.sh

# Inputs
require "PKI_ROOT_CERT" # in: root certificate (file)
require "PKI_ROOT_KEY" # in: root key (file)
require "PKI_ROOT_PASSFILE" # in: root key password (file)

require "PKI_INTER_NAME" # in: intermediate cert name
require "PKI_INTER_PASSFILE" # in: intermediate password file

# Outputs
require "PKI_INTER_CERT" # out: intermediate cert file
require "PKI_INTER_KEY" # out: intermediate key file

# step certificate create <subject> <crt-file> <key-file> [...]
step certificate create \
    $PKI_INTER_NAME \
    $PKI_INTER_CERT \
    $PKI_INTER_KEY \
    --password-file $PKI_INTER_PASSFILE \
    --ca $PKI_ROOT_CERT \
    --ca-key $PKI_ROOT_KEY \
    --ca-password-file $PKI_ROOT_PASSFILE \
    --template template/intermediate.tpl \
    --kty OKP \
    --crv Ed25519


# $PKI_ROOT_NAME is the common name of the certificate
# $PKI_ROOT_CERT is the output cert file
# $PKI_ROOT_KEY is the output key file
# $PKI_ROOT_PASS is the password file to use for securing the key
# `--template template/intermediate.tpl` instructs the use of the specified template
# `--kty OKP` is what key TYPE to generate, "OKP" stands for "octet key pair"
# `--crv Ed25519` is what curve to use
