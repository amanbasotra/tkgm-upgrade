#!/bin/bash

source /tmp/.vcc_credentials
plugin_group_version=`vcc get versions -p vmware_tanzu_kubernetes_grid -s tkg`
echo -e "Available groups for plugin are\n$plugin_group_version"
read -p "Enter plugin group name for tkg: " plugin_version
tanzu plugin search -n management-cluster --show-details
tanzu plugin group get vmware-tkg/default:v$plugin_version
tanzu plugin install --group vmware-tkg/default:v$plugin_version
tkg_plugin_version=`tanzu plugin list`
echo "$tkg_plugin_version"
