# Velocity Docker

Velocity in a docker container.
Velocity is a minecraft proxy server, used to connect multiple game servers together. 

To find out more about Velocity visit https://papermc.io/software/velocity or https://github.com/PaperMC/Velocity

## Usage

Build with:
```sh
docker build -t my-velocity-image .
```

Run with:
```sh
docker run -p 25565:25577 -d --rm --name my-velocity-server \
-v /velocity/install/dir:/velocity \
my-velocity-image
```

Container uses the following environment variables:
- `VERSION`: target major version. does not equate to minecraft version. defaults to `latest`
- `BUILD`: target build. defaults to `latest`
- `MIN_RAM`: jvm min heap size (-Xms). Defaults to `256M`
- `MAX_RAM`: jvm max heap size (-Xmx). Defaults to `1G`
- `JAVA_OPTS`: extra options to be passed to the jvm. optional
