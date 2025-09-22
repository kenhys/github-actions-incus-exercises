#!/bin/bash

set -eux

echo "::group::Run test: list remote"
sudo incus remote list
echo "::endgroup::"

echo -e "\nAll check has passed!\n"
