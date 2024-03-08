#!/bin/bash

management_cluster_list=`tanzu cluster list -n tkg-system --include-management-cluster`
echo "management cluster available $management_cluster_list"
read -p "Enter name of your management cluster you want to upgrade: " mgmt_cluster
read -p "Enter OS type(photon/ubuntu): " os
read -p "Enter K8s version you want to upgrade: " upg_version
tanzu context use "$mgmt_cluster"
tanzu mc kubeconfig get --admin
kubectl config use-context "$mgmt_cluster"-admin@"$mgmt_cluster"
tanzu management-cluster upgrade $mgmt_cluster --os-name $os --timeout 120m0s --yes --verbose 9
management_cluster=`tanzu cluster list -n tkg-system --include-management-cluster`
if [[ "$management_cluster" == *"running"* && "$management_cluster" == *"$upg_version"* ]]; then
  echo "$mgmt_cluster has been successfully upgraded, please check details below"
  echo "$management_cluster"
  tanzu management-cluster kubeconfig get --admin
else
  echo "Unable to upgrade Mgmt Cluster $mgmt_cluster"
  exit 1
 fi
