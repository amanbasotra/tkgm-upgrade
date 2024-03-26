#!/bin/bash

mkdir -p /tanzu/vcc
cd /tanzu/vcc
wget https://github.com/vmware-labs/vmware-customer-connect-cli/releases/download/v1.1.7/vcc-linux-v1.1.7
chmod ugo+x vcc*
sudo mv vcc* /usr/local/bin/vcc
rm -rf /tanzu/vcc
#Exporting VMware user variable

read -p "Enter Customerconnect Username: " VCC_USER
read -s -p "Enter CustomerConnect Password: " VCC_PASS

cd /tmp
touch .vcc_credentials
echo "export VCC_USER='$VCC_USER'">/tmp/.vcc_credentials
echo "export VCC_PASS='$VCC_PASS'">>/tmp/.vcc_credentials
source /tmp/.vcc_credentials
