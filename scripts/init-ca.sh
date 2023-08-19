#!/bin/bash

step ca init \
    --deployment-type=standalone \
    --name=JorisPKI \
    --dns=pki.joris \
    --address=:443 \
    --provisioner=base \
    --password-file=password \
    --no-db
