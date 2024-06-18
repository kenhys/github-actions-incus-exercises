#!/bin/bash

set -eux

echo "::group::Run test: list image alias"
sudo incus image alias list
echo "::endgroup::"

echo -e "\nAll check has passed!\n"
