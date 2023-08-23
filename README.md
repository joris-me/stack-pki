# pki
Everything needed to manage `JorisPKI`. Uses [step-ca](https://github.com/smallstep/certificates/).

# Plan

Current things to do:
- Generate ca.json and compare it against the one in the repository.
    - On mismatch, fail the `test-generate-config` job
- Build image that is preconfigured for ease of use in a `docker-compose.yml`
- Make tests for `generate-root.sh` ? Maybe by `step certificate inspect --format json`
- Make tests for `generate-intermediate.sh` ?

# Manual
Below are all individual steps listed for managing `JorisPKI`.

## Setting up your environment

TODO

## Generate root CA

TODO

## Generate intermediate CA

TODO

## Generate `step-ca` configuration

Run the following in a shell:

```bash
# Bootstrap the automated CA settings.
step ca init \
    --deployment-type=standalone \
    --name=$PKI_ROOT_NAME \
    --dns=$PKI_DNS \
    --address=:443 \
    --provisioner=base \
    --password-file=password \
    --no-db
```

This will have generated our configuration. By default, this includes a single provisioner, the [JWK provisioner](https://smallstep.com/docs/step-ca/provisioners/#jwk).

As we do not intend to use the default generated provisioner(s), we remove them: 
```bash
# Remove all generated provisioners.
cat ca.json | jq "(.authority.provisioners) |= []" > ca.json
```

## Substitute configuration PKI

The steps listed in [Generate step-ca configuration](#generate-step-ca-configuration) have generated a **new**, _separate_ PKI.

To insert 