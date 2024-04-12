#!/bin/bash

read -p "Enter mount point for S3 bucket: " mnt_point_s3
source /tmp/.vcc_credentials
tkg_versions=`vcc get versions -p vmware_tanzu_kubernetes_grid -s tkg`
echo -e "Available TKG Build Versions\n$tkg_versions"
read -p "Enter TKG Build version: " tkg_build_version
tkg_files=`vcc get files -p vmware_tanzu_kubernetes_grid -s tkg -v $tkg_build_version | grep 'photon\|ubuntu'`
echo -e "Available TKG Files for download\n$tkg_files"
read -p "Enter TKG filename for download: " tkg_build_file
vcc download -p vmware_tanzu_kubernetes_grid -s tkg -v $tkg_build_version -f $tkg_build_file --accepteula -o $mnt_point_s3