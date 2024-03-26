#!/bin/bash

tanzu plugin clean
tanzu plugin sync
tanzu_plugin=`tanzu plugin list`
echo "$tanzu_plugin"
