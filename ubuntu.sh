#!/bin/bash

set -ux

# See https://images.linuxcontainers.org/

echo "::group::Run test: show info ubuntu:n"
sudo incus image info ubuntu:n
echo "::endgroup::"

echo "::group::Run test: show info ubuntu:24.04"
sudo incus image info ubuntu:24.04
echo "::endgroup::"

echo "::group::Run test: show info 24.04"
sudo incus image info 24.04
echo "::endgroup::"

echo "::group::Run test: show info noble"
sudo incus image info noble
echo "::endgroup::"

echo "::group::Run test: show info ubuntu:noble"
sudo incus image info ubuntu:noble
echo "::endgroup::"

echo "::group::Run test: show info images:ubuntu/noble"
sudo incus image info images:ubuntu/noble
echo "::endgroup::"

echo "::group::Run test: show info images:ubuntu/24.04"
sudo incus image info images:ubuntu/24.04
echo "::endgroup::"

echo "::group::Run test: list ubuntu images"
sudo incus image list ubuntu:
echo "::endgroup::"

echo -e "\nAll check has passed!\n"
