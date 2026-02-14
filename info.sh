#!/bin/bash

cat /etc/os-release

if [ -x /usr/bin/dnf ]; then
    rpm -q openssl
elif [ -x /usr/bin/apt ]; then
    apt show libssl3t64
else
    :
fi

