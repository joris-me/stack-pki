# pki
All about JorisPKI, using [step-ca](https://github.com/smallstep/certificates/).

# Table of Contents

- [Deployment](#deployment)
- [Commands](#commands)

# Deployment

To write.

# Commands

## Generate root CA
```bash
# step certificate create <subject> <crt-file> <key-file> [...]
step certificate create \
    "JorisPKI Root R0" \
    root.crt \
    root.key \
    --template template/root.tpl \
    --kty OKP
```

- `"JorisPKI Root R0"` is the common name of the certificate
- `root.crt` is the output cert
- `root.key` is the output key
- `--template template/root.tpl` instructs the use of the specified template
- `--kty OKP` is what key to generate, where "OKP" stands for "octet key pair" for Ed25519

## Generate intermediate CA
```bash
# step certificate create <subject> <crt-file> <key-file> [...]
step certificate create \
    "JorisPKI Intermediate I0" \
    inter.crt \
    inter.key \
    --ca root.crt \
    --ca-key root.key \
    --template template/intermediate.tpl \
    --kty OKP
```

- `"JorisPKI Intermediate I0"` is the common name of the certificate
- `inter.crt` is the output cert
- `inter.key` is the output key
- `--ca root.crt` points to the root certificate
- `--ca root.key` points to the root key to sign the intermediate CA with
- `--template template/intermediate.tpl` instructs the use of the specified template
- `--kty OKP` is what key to generate, where "OKP" stands for "octet key pair" for Ed25519

