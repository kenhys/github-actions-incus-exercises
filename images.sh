#!/bin/bash

set -ux

echo "::group::Run test: list images"
sudo incus image list images:
echo "::endgroup::"

echo "::group::Run test: show info images:centos/7"
sudo incus image info images:centos/7
echo "::endgroup::"

echo "::group::Run test: show info images:amazonlinux/2"
sudo incus image info images:amazonlinux/2
echo "::endgroup::"

echo "::group::Run test: show info images:amazonlinux/2023"
sudo incus image info images:amazonlinux/2023
echo "::endgroup::"

echo -e "\nAll check has passed!\n"
