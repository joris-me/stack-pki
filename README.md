# pki
Everything needed to manage `JorisPKI`. Uses [step-ca](https://github.com/smallstep/certificates/).

# Manual
Below are all individual steps listed for managing `JorisPKI`.

## Setting up your environment

Adjust these variables to your liking and store them in `.env`:
```bash
PKI_ROOT_NAME=JorisPKI Root R0
export PKI_DNS=pki.joris
```

## Generate root CA

> These steps should be performed **offline, on an air-gapped machine.**

```bash
export PKI_ROOT_NAME=$PKI_NAME Root R0
export PKI_ROOT_CERT=./root.crt
export PKI_ROOT_KEY=./root.key
export PKI_ROOT_PASSWORD=./root.pass

# step certificate create <subject> <crt-file> <key-file> [...]
step certificate create \
    $PKI_ROOT_NAME \
    $PKI_ROOT_CERT \
    $PKI_ROOT_KEY \
    --template template/root.tpl \
    --kty OKP
```

- `"MyPKI Root CA"` is the common name of the certificate
- `root.crt` is the output cert
- `root.key` is the output key
- `--template template/root.tpl` instructs the use of the specified template
- `--kty OKP` is what key to generate, where "OKP" stands for "octet key pair" for Ed25519

## Generate intermediate CA

> Assumes you have completed the steps in [Generate root CA](#generate-root-ca).

> These steps should be performed **offline, on an air-gapped machine.**

```bash
if [ -z $PKI_ROOT_CERT ]; then exit 1; fi
export PKI_INTERMEDIATE_NAME=$PKI_NAME Intermediate I0
export PKI_INTERMEDIATE_PASSWORD_FILE=./intermediate.pass

# step certificate create <subject> <crt-file> <key-file> [...]
step certificate create \
    "MyPKI Intermediate CA" \
    inter.crt \
    inter.key \
    --ca root.crt \
    --ca-key root.key \
    --template template/intermediate.tpl \
    --kty OKP
```

- `"MyPKI Intermediate CA"` is the common name of the certificate
- `inter.crt` is the output cert
- `inter.key` is the output key
- `--ca root.crt` points to the root certificate
- `--ca root.key` points to the root key to sign the intermediate CA with
- `--template template/intermediate.tpl` instructs the use of the specified template
- `--kty OKP` is what key to generate, where "OKP" stands for "octet key pair" for Ed25519

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