#!/bin/bash

sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.56.2

sudo kubeadm init --pod-network-cidr=10.244.0.0/16 -v=9

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl get pods


kubeadm join 10.0.2.15:6443 --token twlyym.xx6984ibewymyzvw \
        --discovery-token-ca-cert-hash sha256:faefeb07ecff89598bfda2c2e597c778729c15ad5c36c9fc31ef4317c7a4575d


sudo kubectl edit ds weave-net -n kube-system

