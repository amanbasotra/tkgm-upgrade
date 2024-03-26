#!/bin/bash

wkl_cluster_list=`tanzu cluster list`
echo "workload cluster available $wkl_cluster_list"
read -p "Enter name of your workload cluster you want to upgrade: " wrkl_cluster
read -p "Enter OS type(photon/ubuntu): " os
tkr_version_list=`tanzu kubernetes-release get`
echo -e "TKR relaease available for upgrade\n$tkr_version_list"
read -p "Enter TKR version for upgrade(provide prefix eg v1.26.8): " upg_version
workload_cluster_old=`tanzu cluster get $wrkl_cluster`
echo -e "TKC details before upgrade\n$workload_cluster_old"
tanzu cluster upgrade "$wrkl_cluster" --os-name "$os" --tkr "$upg_version" --timeout 120m0s --yes --verbose 9
workload_cluster_new=`tanzu cluster get $wrkl_cluster`
if [[ "$workload_cluster_new" == *"running"* && "$workload_cluster_new" == *"$upg_version"* ]]; then
  echo "Workload Clusters $wrkl_cluster has been successfully upgraded"
  workload_cluster=`tanzu cluster get $wrkl_cluster`
  echo "$workload_cluster"
  tanzu cluster kubeconfig get "$wrkl_cluster" --admin
else
  echo "Unable to upgrade Workload Cluster $wrkl_cluster"
  exit 1
fi

rm -rf /tmp/.vcc_credentials
