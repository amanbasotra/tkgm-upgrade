#!/bin/bash

rm -rf ~/.config/tanzu/tkg/compatibility/tkg-compatibility.yaml
cd /tanzu
mkdir cli
cd /tanzu/cli
cli_versions=`vcc get versions -p vmware_tanzu_cli -s tcli`
echo -e "Available Tanzu Cli Version\n$cli_versions"
read -p "Enter Tanzu Cli version for upgrade: " tanzu_cli_version
cli_files=`vcc get files -p vmware_tanzu_cli -s tcli -v $tanzu_cli_version`
echo -e "Available Tanzu Cli Files\n$cli_files"
read -p "Enter Tanzu Cli filename for upgrade: " tanzu_cli_file
vcc download -p vmware_tanzu_cli -s tcli -v $tanzu_cli_version -f $tanzu_cli_file --accepteula -o /tanzu/cli
gunzip $tanzu_cli_file
tar -xvf tanzu-cli-linux*.tar
sudo mv v$tanzu_cli_version/tanzu-cli-linux_amd64 /usr/local/bin/tanzu
tanzu init
tanzu_version=`tanzu version`
echo "$tanzu_version"
if [[ "$tanzu_version" == *"1.2.0"* ]]; then
  echo "Tanzu CLI has been successfully upgraded"
  rm -rf /tanzu/cli
else
  echo "Unable to upgrade Tanzu CLI"
  exit 1
fi
