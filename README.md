# Docker container to build the PX4 bootloader for the FMUK66

Official guides
- Gitbook: [Programming FMUK66 for first use](https://nxp.gitbook.io/hovergames/userguide/programming)
- Video: [NXP HoverGames - Programming FMUK66 For First Use](https://www.youtube.com/watch?v=55ViAIU3PTM)

## Clone the PX4 bootloader repository
> **NOTE**: Checkout the specific version you would like to build
```
git clone https://github.com/PX4/PX4-Bootloader && cd PX4-Bootloader && git submodule update --init --recursive
```

## Build the docker image
```
docker build -t fmuk66v3_bl .
```

## Run the docker container and create the binary
```
docker run -v $(pwd)/PX4-Bootloader:/build/PX4-Bootloader fmuk66v3_bl:latest
```

Binary will be at `PX4-Bootloader/build/fmuk66v3_bl/fmuk66v3_bl.bin`.
