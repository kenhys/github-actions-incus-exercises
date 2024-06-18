#!/usr/bin/bash

sudo curl -fsSL https://pkgs.zabbly.com/key.asc -o /etc/apt/keyrings/zabbly.asc

TARGET=$1
echo "::group::setup incus stable"
sudo curl -fsSL https://raw.githubusercontent.com/kenhys/github-actions-incus-exercises/main/focal-incus-stable.sources -o /etc/apt/sources.list.d/${TARGET}-incus-stable.sources
echo "::endgroup::"

echo "::group::install incus"
sudo apt -y update
sudo apt-get install -y incus
echo "::endgroup::"

echo "::group::initialize incus"
sudo incus admin init --minimal
echo "::endgroup::"

echo "::group::check incus service status"
sudo systemctl status incus
echo "::endgroup::"

echo "::group::start incus"
sudo systemctl start incus
echo "::endgroup::"
