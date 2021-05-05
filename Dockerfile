FROM ubuntu:18.04

WORKDIR /build

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
      build-essential \
      bzip2 \
      python3 && \
    apt-get clean && \
    ln -s /usr/bin/python3 /usr/bin/python

ARG ARM_GCC_BUNDLE_BASE_NAME=gcc-arm-none-eabi-7-2017-q4-major
ARG ARM_GCC_HOST_ARCHITECTURE=linux
ARG ARM_GCC_BUNDLE_NAME=${ARM_GCC_BUNDLE_BASE_NAME}-${ARM_GCC_HOST_ARCHITECTURE}
ARG ARM_GCC_BUNDLE_FULL=${ARM_GCC_BUNDLE_NAME}.tar.bz2
ARG ARM_GCC_BUNDLE_MD5_CHECKSUM=d3b00ae09e847747ef11316a8b04989a

COPY ./${ARM_GCC_BUNDLE_FULL} ./
RUN echo ${ARM_GCC_BUNDLE_MD5_CHECKSUM} ${ARM_GCC_BUNDLE_FULL} | md5sum --check - && \
    tar -xjf ${ARM_GCC_BUNDLE_FULL}

ENV PATH "/build/${ARM_GCC_BUNDLE_BASE_NAME}/bin:$PATH"

ARG PX4_BOOTLOADER_REPOSITORY_NAME=PX4-Bootloader

WORKDIR /build/${PX4_BOOTLOADER_REPOSITORY_NAME}
ENTRYPOINT ["make", "--jobs=12", "fmuk66v3_bl"]

