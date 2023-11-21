# Velocity Docker

Velocity in a docker container.
Velocity is a minecraft proxy server, used to connect multiple game servers together. 

To find out more about Velocity visit https://papermc.io/software/velocity or https://github.com/PaperMC/Velocity

## Usage

Build with:
```
docker build -t my-velocity-image .
```

Run with:
```
docker run -p 25565:25577 -d --rm --name my-velocity-server \
-v /velocity/install/dir:/velocity \
my-velocity-image \
```
