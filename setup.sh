#!/usr/bin/bash

sudo curl -fsSL https://pkgs.zabbly.com/key.asc -o /etc/apt/keyrings/zabbly.asc

TARGET=$1
echo "::group::setup incus stable"
sudo curl -fsSL https://raw.githubusercontent.com/kenhys/github-actions-incus-exercises/main/${TARGET}-incus-stable.sources -o /etc/apt/sources.list.d/${TARGET}-incus-stable.sources
echo "::endgroup::"

echo "::group::install incus"
sudo apt -y update
sudo apt-get install -y incus
echo "::endgroup::"

# See https://github.com/groonga/groonga/blob/main/.github/workflows/setup.yml
# https://linuxcontainers.org/incus/docs/main/howto/network_bridge_firewalld/#prevent-connectivity-issues-with-incus-and-docker
echo Allow egress network traffic flows for Incus
sudo iptables -I DOCKER-USER -i incusbr0 -j ACCEPT
sudo iptables -I DOCKER-USER -o incusbr0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

echo "::group::initialize incus"
sudo incus admin init --auto
echo "::endgroup::"

echo "::group::check incus service status"
sudo systemctl status incus
echo "::endgroup::"

echo "::group::start incus"
sudo systemctl restart incus
echo "::endgroup::"
