#!/bin/bash

set -ux

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

echo "::group::Run test: list ubuntu images"
sudo incus image list ubuntu:
echo "::endgroup::"



echo -e "\nAll check has passed!\n"
