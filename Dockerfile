FROM gliderlabs/alpine:3.1

RUN apk-install curl


RUN curl -Lk https://circle-artifacts.com/gh/sequenceiq/packer/31/artifacts/0/tmp/circle-artifacts.WEL9Qbl/packer.tgz \
    | tar -xzv -C /usr/local/bin

RUN curl -Lk https://circle-artifacts.com/gh/sequenceiq/packer-azure/2/artifacts/0/tmp/circle-artifacts.NQX55mk/packer.tgz \
    | tar -xzv -C /usr/local/bin

VOLUME /data
WORKDIR /data

ENTRYPOINT [ "/usr/local/bin/packer" ]
