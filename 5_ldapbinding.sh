#!/bin/bash

mkdir -p /tanzu/ldap
read -p "Management cluster config file: " mgmt_cluster_config_file
FILTER_BY_ADDON_TYPE=authentication/pinniped tanzu management-cluster create --dry-run -f $mgmt_cluster_config_file > /tanzu/ldap/PINNIPED-PACKAGE-SECRET.yaml
ldap=`kubectl apply -f /tanzu/ldap/PINNIPED-PACKAGE-SECRET.yaml`
sleep 20
echo "$ldap"
rm -rf /tanzu/ldap
