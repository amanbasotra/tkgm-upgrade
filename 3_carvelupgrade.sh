#!/bin/bash

rm -rf /usr/local/bin/ytt
rm -rf /usr/local/bin/kapp
rm -rf /usr/local/bin/kbld
rm -rf /usr/local/bin/imgpkg
mkdir -p /tanzu/carvel
cd /tanzu/carvel
source /tmp/.vcc_credentials
plugin_group_version=`vcc get versions -p vmware_tanzu_kubernetes_grid -s tkg`
echo -e "Available groups for carvel tools are\n$plugin_group_version"
read -p "Enter carvel tools group name for tkg: " plugin_version
carvel_tools=`vcc get files -p vmware_tanzu_kubernetes_grid -s tkg -v 2.3.1 | grep tkg-carvel-tools-*`
echo -e "Available carvel tool files:\n$carvel_tools"
read -p "Enter carvel tools for install/upgrade: " carvel_file
vcc download -p vmware_tanzu_kubernetes_grid -s tkg -v $plugin_version -f $carvel_file --accepteula -o /tanzu/carvel;

#Untaring Carvel tool packages
cd /tanzu/carvel
gunzip tkg*
tar -xvf tkg*

# Upgrade Carvel Tools
cd /tanzu/carvel/cli/
# ytt
gunzip ytt*
chmod ugo+x ytt*
mv ./ytt* /usr/local/bin/ytt
sudo tt_version=`ytt --version`
echo "$ytt_version"

# kapp
gunzip kapp*
chmod ugo+x kapp*
sudo mv ./kapp* /usr/local/bin/kapp
kapp_version=`kapp --version`
echo "$kapp_version"

# kbld
gunzip kbld*
chmod ugo+x kbld*
sudo mv ./kbld* /usr/local/bin/kbld
kbld_version=`kbld --version`
echo "$kbld_version"

# imgpkg
gunzip imgpkg*
chmod ugo+x imgpkg*
sudo mv ./imgpkg* /usr/local/bin/imgpkg
imgpkg_version=`imgpkg --version`
echo "$imgpkg_version"


rm -rf /tanzu/carvel
