
This docker image aim is to run packer in a Docker container. 
There is an official [hashicorp/packer](https://registry.hub.docker.com/u/hashicorp/packer/)
Docker image but our goal was:

- smaller image size: hashicorp/packer is around 700 Mb
- build from of master: there are a couple of bug fixes we rely on, not yet released
- include additional plugins: especially the [azure builder](https://github.com/MSOpenTech/packer-azure/)

The main idea is that you can use a lean [Alpine linux](https://github.com/gliderlabs/docker-alpine),
and put only the packer binaries into it.

## Usage

You can use Docker volume to inject you packer JSON into the container:
```
$ docker run -it --rm \
  -v $(pwd):/data \
  -w /data \
  sequenceiq/packer:v0.7.5.dev \
    build packer.json
```

## Alias

To make life easier you can create an alias which is an in-place replacement for a locally installed packer:

```
$ alias packer='docker run -it --rm -v $(pwd):/data -w /data sequenceiq/packer:v0.7.5.dev'
```
After that you can use it as easy as:

```
packer validate mypacker.json
```

