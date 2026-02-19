#!/bin/bash

set -exu

GATEWAY=$(ip route | grep default | cut -d' ' -f3)

# install latest fluent-package
curl --location --output fluent-package.rpm https://fluentd.cdn.cncf.io/test/fluent-package-6.0.2-1.el10.x86_64.rpm
sudo yum install -y ./fluent-package.rpm

(! systemctl status --no-pager fluentd)

# Overwrite with s3.conf
sed -e "s/10.0.2.2/${GATEWAY}/" /host/elasticsearch.conf > /tmp/elasticsearch.conf
sudo cp /tmp/elasticsearch.conf /etc/fluent/fluentd.conf
cat /etc/fluent/fluentd.conf

curl "http://${GATEWAY}:9200/_cat/indices?v"

sudo systemctl enable --now fluentd
systemctl status --no-pager fluentd

# wait loading sample data
sleep 15

count=$(curl "http://${GATEWAY}:9200/_cat/indices?v" | grep -c fluentd-test)
test $count -eq 1

curl "http://${GATEWAY}:9200/_search?q=message:hello&pretty"
