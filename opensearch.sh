#!/bin/bash

set -exu

GATEWAY=$(ip route | grep default | cut -d' ' -f3)

# install latest fluent-package
curl --location --output fluent-package.rpm https://fluentd.cdn.cncf.io/test/fluent-package-6.0.2-1.el10.x86_64.rpm
sudo yum install -y ./fluent-package.rpm

sudo yum install -y jq

(! systemctl status --no-pager fluentd)

# Overwrite with s3.conf
sed -e "s/localhost/${GATEWAY}/" /host/opensearch.conf > /tmp/opensearch.conf
sudo cp /tmp/opensearch.conf /etc/fluent/fluentd.conf
cat /etc/fluent/fluentd.conf

curl --silent --insecure --user admin:Passvv0rd@ "https://${GATEWAY}:9200/_cat/indices?v"

sudo systemctl enable --now fluentd
systemctl status --no-pager fluentd

# wait loading sample data
until curl --silent --insecure --user admin:Passvv0rd@ "https://${GATEWAY}:9200/_cat/indices?v" | grep -c 'fluentd-test'; do
    sleep 10
done

count=$(curl --silent --insecure --user admin:Passvv0rd@ "https://${GATEWAY}:9200/_search?q=message:hello&pretty" | jq ".hits.hits | length")
test $count -gt 0
