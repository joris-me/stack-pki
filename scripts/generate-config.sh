#!/bin/bash
source scripts/util.sh

require PKI_DNS
require PKI_INTERMEDIATE_NAME

# Generate the CA configuration.
step ca init \
    --deployment-type=standalone \
    --name=$PKI_ROOT_NAME \
    --dns=$PKI_DNS \
    --address=:443 \
    --provisioner=base \
    --password-file=password \
    --no-db

# Remove all generated provisioners
cat ca.json | jq "(.authority.provisioners) |= []" > ca.json

