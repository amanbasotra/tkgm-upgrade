#!/bin/bash

rm -rf /usr/local/bin/kubectl
mkdir -p /tanzu/kubectl
cd /tanzu/kubectl
plugin_group_version=`vcc get versions -p vmware_tanzu_kubernetes_grid -s tkg`
echo -e "Available groups for kubectl plugin are\n$plugin_group_version"
read -p "Enter kubectl plugin group name for tkg: " plugin_version
kubectl_versions=`vcc get files -p vmware_tanzu_kubernetes_grid -s tkg -v $plugin_version | grep kubectl-*`
echo -e "Available Kubectl files:\n$kubectl_versions"
read -p "Enter kubectl file for install/upgrade: " kubectl_file
vcc download -p vmware_tanzu_kubernetes_grid -s tkg -v $plugin_version -f $kubectl_file --accepteula -o /tanzu/kubectl
gunzip kubectl*
chmod ugo+x kubectl*
sudo install kubectl* /usr/local/bin/
sudo mv kubectl* /usr/local/bin/kubectl
kubectl_version=`kubectl version`
echo -e "Kubectl version are:\n$kubectl_version"
rm -rf /tanzu/kubectl
sleep 5
