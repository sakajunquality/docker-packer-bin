FROM gliderlabs/alpine:3.1

RUN apk-install curl


RUN curl -Lk https://circle-artifacts.com/gh/sequenceiq/packer/35/artifacts/0/tmp/circle-artifacts.d20CmZY/packer.tgz \
    | tar -xzv -C /usr/local/bin

RUN curl -Lk https://circle-artifacts.com/gh/sequenceiq/packer-azure/2/artifacts/0/tmp/circle-artifacts.NQX55mk/packer.tgz \
    | tar -xzv -C /usr/local/bin

RUN curl -L https://github.com/sequenceiq/packer/releases/download/v0.8.7/packer-builder-amazon-ebs-mock-Linux.tgz \
    | tar -xzv -C /usr/local/bin/

RUN curl -L https://github.com/sequenceiq/packer-postprocessor-generator/releases/download/v0.8.7/packer-post-processor-generator-Linux.tgz \
    | tar -xzv -C /usr/local/bin/

VOLUME /data
WORKDIR /data

ENTRYPOINT [ "/usr/local/bin/packer" ]
