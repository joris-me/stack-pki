FROM smallstep/step-ca:0.24.2-hsm

RUN mkdir -p /config/certs
COPY image/ca.json /config/ca.json
COPY *.crt /config/certs

RUN ["step-ca", "--password-file", "$q"]