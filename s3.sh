#!/bin/bash

set -exu

# install_aws_cli
ARCH=$(rpm --eval '%{_arch}')
case $ARCH in
    x86_64)
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        ;;
    arm*)
        curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
        ;;
    *)
        ;;
esac
sudo yum install -y unzip
unzip awscliv2.zip
sudo ./aws/install

# install latest fluent-package
sudo rpm -ivh https://fluentd.cdn.cncf.io/test/fluent-package-6.0.2-1.el10.x86_64.rpm

(! systemctl status --no-pager fluentd)

# Overwrite with s3.conf
sudo cp /host/s3.conf /etc/fluent/fluentd.conf

# Check container => host localstack connectivity
curl http://10.0.2.2:4566/_localstack/health

sudo systemctl enable --now fluentd
systemctl status --no-pager fluentd

# wait loading sample data
sleep 15

AWS_ACCESS_KEY_ID=localstack-test AWS_SECRET_ACCESS_KEY=localstack-test aws --endpoint-url=http://10.0.2.2:4566 s3 ls localstack-bucket
