FROM gliderlabs/alpine:3.1

RUN apk-install curl


ADD https://circle-artifacts.com/gh/sequenceiq/packer/31/artifacts/0/tmp/circle-artifacts.WEL9Qbl/packer.tgz /tmp/packer.tgz
ADD https://circle-artifacts.com/gh/sequenceiq/packer-azure/2/artifacts/0/tmp/circle-artifacts.NQX55mk/packer.tgz /tmp/packer-azure.tgz

#COPY packer*.tgz /tmp/*.tgz /tmp/

VOLUME /data
WORKDIR /data

ENTRYPOINT [ "sh" ]
