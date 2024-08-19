#!/bin/bash
# Set hostname
hostnamectl set-hostname ${HOSTNAME}

# Update package list and install prerequisites
apt-get update
apt-get install -y apt-transport-https ca-certificates curl

# Install Kubernetes tools
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubelet kubeadm kubectl

# Enable and start kubelet
systemctl enable kubelet
systemctl start kubelet
