#!/bin/bash

cat /etc/os-release

if [ -x /usr/bin/dnf ]; then
    dnf install -y openssl-devel
    dnf update -y
    rpm -qa | grep openssl
    cat /etc/yum.repos.d/*.repo
elif [ -x /usr/bin/apt ]; then
    apt show libssl3t64
else
    :
fi

