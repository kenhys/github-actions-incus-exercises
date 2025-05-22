#!/bin/bash

set -eux

image=$1

echo "::group::Run test: collect information"
sudo incus image info $image
echo "::endgroup::"

echo "::group::Run test: launch $image"
sudo incus launch $image target
sleep 5
echo "::endgroup::"

echo "::group::Run test: configure $image"
sudo incus config device add target host disk source=$PWD path=/host
sudo incus list
echo "::endgroup::"

echo "::group::Run test: show container info"
sudo incus exec target -- /host/info.sh
echo "::endgroup::"

echo "::group::Run test: cleanup $image"
sudo incus stop target
sudo incus delete target
echo "::endgroup::"

echo -e "\nAll Success!\n"
