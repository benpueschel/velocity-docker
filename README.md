# Velocity Docker

Velocity in a docker container.
Velocity is a minecraft proxy server, used to connect multiple game servers together.

To find out more about Velocity visit https://papermc.io/software/velocity or https://github.com/PaperMC/Velocity

## Quick Start

The image is available on Docker Hub as `benpueschel/velocity` and on the
GitHub Container Registry as `ghcr.io/benpueschel/velocity-docker:main`.
To automatically pull the image and run a container, use:
```sh
docker run -p 25565:25565 -dit --rm --name my-velocity-server \
-v my-velocity-volume:/home/minecraft/velocity \
benpueschel/velocity
```

Container uses the following environment variables:
- `VERSION`: target major version. does not equate to minecraft version. defaults to `latest`
- `BUILD`: target build. defaults to `latest`
- `MIN_RAM`: jvm min heap size (-Xms). Defaults to `256M`
- `MAX_RAM`: jvm max heap size (-Xmx). Defaults to `1G`
- `JAVA_OPTS`: extra options to be passed to the jvm. Defaults to [Velocity's recommended flags](https://docs.papermc.io/velocity/tuning/).

## Manual Build

First, clone the repository:
```sh
git clone https://github.com/benpueschel/velocity-docker.git && cd velocity-docker
```

Then build the image with:
```sh
docker build -t my-velocity-image .
```

Finally, run the container with the custom image:
```sh
docker run -p 25565:25565 -d --rm --name my-velocity-server \
-v my-velocity-volume:/home/minecraft/velocity \
my-velocity-image
```
