#!/bin/bash

# Vars
LIBSODIUM_VERSION=1.0.13
LIBSODIUM_SHA256=9c13accb1a9e59ab3affde0e60ef9a2149ed4d6e8f99c93c7a5b97499ee323fd
LIBSODIUM_DOWNLOAD_URL=https://download.libsodium.org/libsodium/releases/libsodium-${LIBSODIUM_VERSION}.tar.gz
DNSCRYPT_WRAPPER_VERSION=0.3
DNSCRYPT_WRAPPER_SHA256=ec5c290ba9b9a05536fa6ee827373ca9b3841508e6d075ae364405152446499c
DNSCRYPT_WRAPPER_DOWNLOAD_URL=https://github.com/Cofyc/dnscrypt-wrapper/releases/download/v${DNSCRYPT_WRAPPER_VERSION}/dnscrypt-wrapper-v${DNSCRYPT_WRAPPER_VERSION}.tar.bz2

# Install dependencies
sudo apt-get -y install autoconf libevent-dev

# Get build and install libsodium
cd /tmp
curl -sSL $LIBSODIUM_DOWNLOAD_URL -o libsodium.tar.gz
echo "${LIBSODIUM_SHA256} *libsodium.tar.gz" | sha256sum -c -
tar xzf libsodium.tar.gz
rm -f libsodium.tar.gz
cd libsodium-${LIBSODIUM_VERSION}
./configure --disable-dependency-tracking --enable-minimal --prefix=/opt/libsodium
make check && make install
echo /opt/libsodium/lib > /etc/ld.so.conf.d/libsodium.conf && ldconfig

# Get, build and install dnscrypt-wrapper
cd /tmp
curl -sSL $DNSCRYPT_WRAPPER_DOWNLOAD_URL -o dnscrypt-wrapper.tar.bz2
echo "${DNSCRYPT_WRAPPER_SHA256} *dnscrypt-wrapper.tar.bz2" | sha256sum -c -
tar xjf dnscrypt-wrapper.tar.bz2
cd dnscrypt-wrapper-v${DNSCRYPT_WRAPPER_VERSION}
make configure
./configure --prefix=/opt/dnscrypt-wrapper --with-sodium=/opt/libsodium
make install
