FROM smallstep/step-ca:0.24.2-hsm

# Create /config as root, then chown it to the `step` user
USER 0
RUN mkdir -p /config/certs && \
    mkdir -p /config/secrets && \
    chown -R /config $STEPUID:$STEPGUID

# Bake the `ca.json` in the image
COPY image/ca.json /config/ca.json

# Files/volumes needed:
#  - /config/certs/root.crt: should be root cert
#  - /config/certs/intermediate.crt: should be intermediate cert
#  - /config/secrets/intermediate.key: should be intermediate private key 
#  - /config/secrets/intermediate.pass: file containing the intermediate CA key password
#  - /config/secrets
RUN ["step-ca", "--password-file", "$q"]

USER $STEPUID