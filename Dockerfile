FROM --platform=arm64 smallstep/step-ca:0.24.2

RUN mkdir /config
COPY ca.json /config/ca.json
COPY *.crt /config/
