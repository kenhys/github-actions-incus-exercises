#!/bin/bash

set -ux

echo "::group::Run test: show info ubuntu:n"
incus image info ubuntu:n
echo "::endgroup::"

echo "::group::Run test: show info ubuntu:24.04"
incus image info ubuntu:24.04
echo "::endgroup::"

echo "::group::Run test: show info 24.04"
incus image info 24.04
echo "::endgroup::"

echo "::group::Run test: show info noble"
incus image info noble
echo "::endgroup::"

echo "::group::Run test: list ubuntu images"
incus image list ubuntu:
echo "::endgroup::"



echo -e "\nAll check has passed!\n"
