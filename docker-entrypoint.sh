#!/bin/sh

#sed -i '/restart: always/a \    labels:\n      kompose.service.type: loadbalancer\n      kompose.service.expose: "true"' /tmp/docker-compose-resolved.yaml

echo " - Configuration for local DNS"
echo -e 'nameserver 8.8.8.8\nnameserver 8.8.4.4' > /etc/resolv.conf
cat /etc/resolv.conf

apk update
apk add git curl openssh bash jq
echo " - Install some tools for debug"
apk add diffutils bash-completion
# docker-bash-completion 

cd /opt/
git clone git@gitlab.funpodium.net:devops/aws-eks-lab.git

echo " - Installl aws-iam-authenticator"
curl -o /usr/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator
chmod 755 /usr/bin/aws-iam-authenticator
ls -l /usr/bin/aws-iam-authenticator

echo " - Install kubectl"
curl -o /usr/bin/kubectl -LO https://storage.googleapis.com/kubernetes-release/release/v1.15.1/bin/linux/amd64/kubectl
chmod 755 /usr/bin/kubectl
ls -l /usr/bin/kubectl

echo " - Install aws-cli"
apk -Uuv add groff less python py-pip
pip install awscli
apk --purge -v del py-pip
rm /var/cache/apk/*

echo " - Install eksctl"
curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /usr/local/bin/
#mv /tmp/eksctl /usr/local/bin
ls -l /usr/local/bin/eksctl

top

# --- END --- #
